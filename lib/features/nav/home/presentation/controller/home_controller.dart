import 'package:get/get.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class HomeController extends GetxController {
  List? tours = [];
  List<Map<String, dynamic>> globalTourList = [];
  final GetuserUseCase _getuserUseCase;
  HomeController(this._getuserUseCase);

  @override
  void onInit() {
    fetchDataTour();
    super.onInit();
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

  List<Map<String, dynamic>> destinations = [];

  void updateIndex(int index) {
    currentIndexCarouselImage.value = index;
  }

  // Future<void> fetchDataTour() async {
  //   final apiService = ApiService("http://10.0.2.2:3000");
  //   final String endpoint = "/tours";

  //   try {
  //     // Gọi API để lấy danh sách tour
  //     final response = await apiService.getData(endpoint);
  //     print("Fetched tours: $response"); // In ra dữ liệu nhận được

  //     // Giả sử response là một danh sách các tour, cập nhật danh sách destinations
  //     destinations = response.map<Map<String, dynamic>>((tour) {
  //       return {
  //         'imageUrl': tour['IMAGES']
  //             [0], // Lấy hình ảnh đầu tiên từ danh sách hình ảnh
  //         'title': tour['TOUR_NAME'],
  //         'description':
  //             tour['DESCRIPTION'], // Sử dụng trường 'DESCRIPTION' làm vị trí
  //         'price': '${tour['PRICE_PER_PERSON']} VNĐ', // Định dạng lại giá
  //       };
  //     }).toList();
  //     print("Fetched tours: $destinations");
  //     update(); // Cập nhật UI
  //   } catch (e) {
  //     print("Error fetching tours: $e");
  //     // Xử lý lỗi ở đây (ví dụ: thông báo cho người dùng)
  //   }
  // }

  Future<void> fetchDataTour() async {
    try {
      // Lấy token từ Prefs thông qua GetuserUseCase
      final AuthenticationModel? authModel = await _getuserUseCase.getToken();

      if (authModel == null || authModel.metadata.isEmpty) {
        print("Error: Token is missing");
        return;
      }

      final String token = authModel.metadata;

      // Khởi tạo ApiService với token lấy được
      final apiService = ApiService("http://10.0.2.2:3000", token);
      final String endpoint = "/tours";

      // Gọi API để lấy danh sách tour
      final response = await apiService.getData(endpoint);
      // print("Fetched tours: $response["IMAGES"]");

      // Giả sử response là một danh sách các tour, cập nhật danh sách destinations
      destinations = response.map<Map<String, dynamic>>((tour) {
        return tour;
      }).toList();
      tours = response;
      print(tours);
      update();
    } catch (e) {
      print("Error fetching tours: $e");
      // Xử lý lỗi ở đây (ví dụ: thông báo cho người dùng)
    }
  }
}
