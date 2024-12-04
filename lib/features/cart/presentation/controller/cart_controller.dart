import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reading_app/core/configs/const/enum.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/core/ui/dialogs/dialogs.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class CartController extends GetxController {
  final GetuserUseCase _getuserUseCase;
  CartController(this._getuserUseCase);
  var selectedTours = <Map<String, dynamic>>[].obs;
  var totalPrice = 0.0.obs;
  var selectedDate = ''.obs;
  var availableSlots = 0.obs;
  var startTime = ''.obs;
  var endDate = ''.obs;
  var endDateSelected = ''.obs;

  var numberOfPeople = 1.obs;
  @override
  void onInit() async {
    await fetchDataCart();
    super.onInit();
  }

  RxMap<dynamic, dynamic> cartTour = {}.obs;

  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    // Sử dụng `double.tryParse` để chuyển chuỗi thành số, trả về 0 nếu chuyển đổi không thành công
    final doublePrice = double.tryParse(price) ?? 0.0;
    return formatter.format(doublePrice);
  }

  Future<void> fetchDataCart() async {
    try {
      // Lấy token từ Prefs thông qua GetuserUseCase
      late String userId;
      final AuthenticationModel? authModel = await _getuserUseCase.getToken();
      if (authModel == null || authModel.metadata.isEmpty) {
        print("Error: Token is missing");
        return;
      }
      final String token = authModel.metadata;
      final Map<String, dynamic>? decodedToken =
          _getuserUseCase.decodeAccessToken(token);

      if (decodedToken != null) {
        userId = decodedToken['userId'];
        print("UserId: $userId");
      } else {
        print("Failed to decode token or userId is missing");
      }

      final apiService =
          ApiService("http://10.0.2.2:3000/carts/allTourCart", token);
      final String endpoint = "/$userId";

      final response = await apiService.getDataJSON(endpoint);

      // Thêm trường `isChecked` cho từng tour
      if (response['LIST_TOUR_REF'] != null) {
        for (var tour in response['LIST_TOUR_REF']) {
          tour['isChecked'] = false; // Mặc định chưa chọn
        }
      }

      cartTour.value = response;
      update(); // Cập nhật UI
    } catch (e) {
      print("Error fetching tours: $e");
    }
  }

  // Phương thức để xóa một tour khỏi giỏ hàng
  void removeFromCart(Map<String, dynamic> tour) {
    cartTour['LIST_TOUR_REF'].remove(tour);
    cartTour.refresh(); // Cập nhật giao diện sau khi xóa
    _calculateTotal(); // Tính toán lại tổng tiền sau khi xóa
  }

// Phương thức để cập nhật trạng thái checkbox của một tour
  void updateItemCheckStatus(int index, bool isChecked) {
    cartTour['LIST_TOUR_REF'][index]['isChecked'] = isChecked;
    cartTour.refresh(); // Cập nhật giao diện khi trạng thái thay đổi

    // Thêm hoặc xóa tour khỏi selectedTours
    if (isChecked) {
      // Thêm tour vào mảng selectedTours
      selectedTours.add({
        "TOUR_ID": cartTour['LIST_TOUR_REF'][index]['TOUR_ID']['_id'],
        "CALENDAR_TOUR_ID": cartTour['LIST_TOUR_REF'][index]
            ['CALENDAR_TOUR_ID'],
        "START_DATE": cartTour['LIST_TOUR_REF'][index]['START_DATE'],
        "END_DATE": cartTour['LIST_TOUR_REF'][index]['END_DATE'],
        "START_TIME": cartTour['LIST_TOUR_REF'][index]['START_TIME'],
        "SLOT": cartTour['LIST_TOUR_REF'][index]['NUMBER_OF_PEOPLE'],
        "TOTAL_PRICE_TOUR": double.parse(cartTour['LIST_TOUR_REF'][index]
                    ['TOUR_ID']['PRICE_PER_PERSON']
                .toString()) *
            int.parse(
                cartTour['LIST_TOUR_REF'][index]['NUMBER_OF_PEOPLE'].toString())
        //     *
        // double.parse(cartTour['LIST_TOUR_REF'][index]['NUMBER_OF_PEOPLE']),
      });
      print("Selected Tours: $selectedTours");
    } else {
      // Xóa tour khỏi mảng selectedTours
      selectedTours.removeWhere((tour) =>
          tour['TOUR_ID'] ==
          cartTour['LIST_TOUR_REF'][index]['TOUR_ID']['_id']);
      print("Selected Tours: $selectedTours");
    }

    _calculateTotal(); // Tính toán lại tổng tiền
  }

// Phương thức để tính tổng tiền của các tour đã chọn
  void _calculateTotal() {
    double total = 0;
    for (var item in cartTour['LIST_TOUR_REF']) {
      if (item['isChecked'] == true) {
        double pricePerPerson;
        int numberOfPeople;

        // Kiểm tra và chuyển đổi 'PRICE_PER_PERSON'
        if (item['TOUR_ID']['PRICE_PER_PERSON'] is String) {
          pricePerPerson = double.parse(item['TOUR_ID']['PRICE_PER_PERSON']);
        } else {
          pricePerPerson = item['TOUR_ID']['PRICE_PER_PERSON'].toDouble();
        }

        // Kiểm tra và chuyển đổi 'NUMBER_OF_PEOPLE'
        if (item['NUMBER_OF_PEOPLE'] is String) {
          numberOfPeople = int.parse(item['NUMBER_OF_PEOPLE']);
        } else {
          numberOfPeople = item['NUMBER_OF_PEOPLE'];
        }

        total += pricePerPerson * numberOfPeople;
      }
    }
    totalPrice.value = total;
  }

  Future<void> handlePaymentCart() async {
    if (selectedTours.isEmpty) {
      DialogsUtils.showAlertDialog(
        title: 'Thông báo',
        message: 'Vui lòng chọn tour cần thanh toán',
        typeDialog: TypeDialog.success,
        onPresss: () {},
      );
      return;
    }
    await Get.toNamed('/info-payment', arguments: selectedTours);
  }

  Future<void> hanleDeleteItemCart(String TourID) async {
    final AuthenticationModel? authModel = await _getuserUseCase.getToken();

    if (authModel == null || authModel.metadata.isEmpty) {
      print("Error: Token is missing");
      return;
    }
    final String token = authModel.metadata;

    // Khởi tạo ApiService với token lấy được
    final apiService = ApiService("http://10.0.2.2:3000", token);
    final String endpoint = "/carts/removeTourFromCart";
    final data = {
      "TOUR_ID": TourID,
    };
    try {
      final response = await apiService.postData(endpoint, data);
      print(response);
      fetchDataCart();
    } catch (e) {
      print(e);
    }
  }

  // Phương thức tăng giảm số người
  void increasePeople() {
    numberOfPeople.value++; // Tăng số người
  }

  void decreasePeople() {
    if (numberOfPeople.value > 1) {
      numberOfPeople.value--; // Giảm số người
    }
  }

  void updateCartItem(int index, String selectedDate, int selectedPeople) {
    // Cập nhật dữ liệu cho tour trong giỏ hàng
    cartTour['LIST_TOUR_REF'][index]['START_DATE'] = selectedDate;
    cartTour['LIST_TOUR_REF'][index]['NUMBER_OF_PEOPLE'] = selectedPeople;

    // Cập nhật lại tổng giá tiền và giỏ hàng
    // updateTotalPrice();
    cartTour.refresh(); // Cập nhật giao diện sau khi thay đổi dữ liệu
  }

  Future<void> handleUpdateItemCart(Map<String, dynamic> dataUpdate) async {
    final AuthenticationModel? authModel = await _getuserUseCase.getToken();

    if (authModel == null || authModel.metadata.isEmpty) {
      print("Error: Token is missing");
      return;
    }
    final String token = authModel.metadata;
    print("dataUpdate: $dataUpdate");
    // Khởi tạo ApiService với token lấy được
    final apiService = ApiService("http://10.0.2.2:3000", token);
    final idCart = dataUpdate['CART_ID'];
    final String endpoint = "/carts/updateTourInCart/$idCart";
    final data = dataUpdate;
    try {
      final response = await apiService.postData(endpoint, data);
      print(response);
      await fetchDataCart();
    } catch (e) {
      print(e);
    }
  }
}
