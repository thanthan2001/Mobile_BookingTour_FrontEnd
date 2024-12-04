import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/core/services/models/infor_model.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:reading_app/features/auth/user/domain/use_case/save_user_use_case.dart';

import '../../../../auth/user/model/user_model.dart';

class HomeController extends GetxController {
  List? tours = [];
  RxBool isLoading = true.obs;
  List<Map<String, dynamic>> globalTourList = [];
  final GetuserUseCase _getuserUseCase;
  final SaveUserUseCase _saveuserUseCase;
  HomeController(this._getuserUseCase, this._saveuserUseCase);
  var user = Rx<InforModel?>(null);
  List<Map<String, dynamic>> destinations = [];
  List<Map<String, dynamic>> newTours = [];
  @override
  void onInit() async {
    // await fetchDataTour();
    await fetchNewTours();
    await getInforUser();
    await loadUserInfo();
    await fetchTopRevenueTours();
    super.onInit();
  }

  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    // Sử dụng `double.tryParse` để chuyển chuỗi thành số, trả về 0 nếu chuyển đổi không thành công
    final doublePrice = double.tryParse(price) ?? 0.0;
    return formatter.format(doublePrice);
  }

  var currentIndexCarouselImage = 0.obs;
  List<String> categories = [
    "Núi",
    "Thác nước",
    "Hang Động",
    "Biển"
  ]; // Danh sách các category
  RxInt selectedCategory = 0.obs; // Dùng RxInt

  void updateCategory(int index) {
    selectedCategory.value = index;
    update(); // Cập nhật trạng thái
  }

  Future<void> loadUserInfo() async {
    user.value =
        await _getuserUseCase.getInfo(); // Cập nhật giá trị cho user.value
    if (user.value != null) {
      print("User Info: ${user.value!.displayName}");
    } else {
      print("No user info found");
    }
  }

  Future<void> getInforUser() async {
    final AuthenticationModel? authModel = await _getuserUseCase.getToken();
    if (authModel == null || authModel.metadata.isEmpty) {
      print("Error: Token is missing");
      return;
    }
    final String token = authModel.metadata;
    final apiService = ApiService("http://10.0.2.2:3000", token);
    final String endpoint = "/users/profileUser";
    try {
      final response = await apiService.postData(endpoint, {});
      final iduser = response["_id"];
      final email = response["EMAIL"];
      final phoneNumber = response["PHONE_NUMBER"];
      final displayName = response["FULLNAME"];
      final photoURL = response["PHOTO_URL"];
      final infoUser = InforModel(
          displayName: displayName,
          email: email,
          phoneNumber: phoneNumber,
          uid: iduser,
          photoURL: photoURL);
      _saveuserUseCase.saveInfo(infoUser);
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  void updateIndex(int index) {
    currentIndexCarouselImage.value = index;
  }

  // Future<void> fetchDataTour() async {
  //   try {
  //     // Lấy token từ Prefs thông qua GetuserUseCase
  //     final AuthenticationModel? authModel = await _getuserUseCase.getToken();

  //     if (authModel == null || authModel.metadata.isEmpty) {
  //       print("Error: Token is missing");
  //       return;
  //     }

  //     final String token = authModel.metadata;

  //     // Khởi tạo ApiService với token lấy được
  //     final apiService = ApiService("http://10.0.2.2:3000", token);
  //     final String endpoint = "/tours";

  //     // Gọi API để lấy danh sách tour
  //     final response = await apiService.getData(endpoint);
  //     // print("Fetched tours: $response["IMAGES"]");

  //     // Giả sử response là một danh sách các tour, cập nhật danh sách destinations
  //     destinations = response.map<Map<String, dynamic>>((tour) {
  //       return tour;
  //     }).toList();
  //     tours = response;
  //     // print(tours);
  //     update();
  //   } catch (e) {
  //     print("Error fetching tours: $e");
  //     // Xử lý lỗi ở đây (ví dụ: thông báo cho người dùng)
  //   }
  // }

  Future<void> fetchNewTours() async {
    try {
      final AuthenticationModel? authModel = await _getuserUseCase.getToken();

      if (authModel == null || authModel.metadata.isEmpty) {
        print("Error: Token is missing");
        return;
      }

      final String token = authModel.metadata;
      final apiService = ApiService("http://10.0.2.2:3000", token);
      final String endpoint = "/tours/latestTours";
      final response = await apiService.getDataJSON(endpoint);
      if (response['success'] == true && response['data'] != null) {
        newTours = List<Map<String, dynamic>>.from(response['data']);
        update();
      } else {
        print("No data found or error in response");
      }
    } catch (e) {
      print("Error fetching new tours: $e");
    }
  }

  Future<void> fetchTopRevenueTours() async {
    try {
      final AuthenticationModel? authModel = await _getuserUseCase.getToken();

      if (authModel == null || authModel.metadata.isEmpty) {
        print("Error: Token is missing");
        return;
      }

      final String token = authModel.metadata;
      final apiService = ApiService("http://10.0.2.2:3000", token);
      final String endpoint = "/tours/top-revenue-tours";

      // Gọi API để lấy top revenue tours
      final response = await apiService.getDataJSON(endpoint);
      if (response['success'] == true && response['data'] != null) {
        destinations = List<Map<String, dynamic>>.from(response['data']);
        update(); // Cập nhật giao diện khi có dữ liệu mới
      } else {
        print("No data found or error in response");
      }
    } catch (e) {
      print("Error fetching top revenue tours: $e");
    }
  }
}
