import 'package:get/get.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class CartController extends GetxController {
  final GetuserUseCase _getuserUseCase;
  CartController(this._getuserUseCase);

  @override
  void onInit() async {
    await fetchDataCart();
    super.onInit();
  }

  RxMap<dynamic, dynamic> cartTour = {}.obs;
  var totalPrice = 0.0.obs;

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
    _calculateTotal(); // Tính toán lại tổng tiền khi trạng thái thay đổi
  }

// Phương thức để tính tổng tiền của các tour đã chọn
  void _calculateTotal() {
    double total = 0;
    for (var item in cartTour['LIST_TOUR_REF']) {
      if (item['isChecked'] == true) {
        total += double.parse(item['TOUR_ID']['PRICE_PER_PERSON']) *
            double.parse(
                item["NUMBER_OF_PEOPLE"]); // Tính tổng giá cho các tour đã chọn
      }
    }
    totalPrice.value = total; // Cập nhật tổng tiền
  }
}
