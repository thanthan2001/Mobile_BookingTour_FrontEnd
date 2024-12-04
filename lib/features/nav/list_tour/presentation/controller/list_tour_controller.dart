import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/core/services/models/infor_model.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class ListTourController extends GetxController {
  var destinations = <Map<String, dynamic>>[].obs;
  var tours = <Map<String, dynamic>>[].obs;
  var user = Rx<InforModel?>(null);
  var filteredTours = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var selectedFilter = ''.obs; // Biến lưu bộ lọc hiện tại

  final GetuserUseCase _getuserUseCase;
  ListTourController(this._getuserUseCase);

  @override
  void onInit() async {
    super.onInit();
    await loadUserInfo();
    fetchDataTour();
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

  Future<void> fetchDataTour() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final AuthenticationModel? authModel = await _getuserUseCase.getToken();

      if (authModel == null || authModel.metadata.isEmpty) {
        errorMessage.value = "Error: Token is missing";
        return;
      }

      final String token = authModel.metadata;
      final apiService = ApiService("http://10.0.2.2:3000", token);
      final String endpoint = "/tours";

      final response = await apiService.getData(endpoint);

      if (response != null && response is List) {
        tours.value = response.cast<Map<String, dynamic>>();
        destinations.value = response.cast<Map<String, dynamic>>();
        filteredTours.value = tours; // Hiển thị tất cả tour ban đầu
      } else {
        errorMessage.value = "No tours found or invalid response format";
      }
    } catch (e) {
      errorMessage.value = "Error fetching tours: $e";
    } finally {
      isLoading.value = false;
    }
  }

  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    // Sử dụng `double.tryParse` để chuyển chuỗi thành số, trả về 0 nếu chuyển đổi không thành công
    final doublePrice = double.tryParse(price) ?? 0.0;
    return formatter.format(doublePrice);
  }

  // Hàm để cập nhật bộ lọc và lọc danh sách tour
  void updateFilter(String filter) {
    selectedFilter.value = filter;
    if (filter == 'Tất cả' || filter.isEmpty) {
      // Hiển thị tất cả tour khi chọn "Tất cả"
      filteredTours.value = tours;
    } else {
      // Lọc danh sách tour theo loại
      filteredTours.value = tours.where((tour) {
        return tour['TYPE'] == filter;
      }).toList();
    }
  }
}
