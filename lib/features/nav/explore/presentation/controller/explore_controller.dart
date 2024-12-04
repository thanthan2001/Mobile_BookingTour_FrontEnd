import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class ExploreController extends GetxController {
  final GetuserUseCase _getuserUseCase;
  var searchText = ''.obs;
  var searchResults = [].obs;
  TextEditingController textController = TextEditingController();
  ExploreController(this._getuserUseCase);

  @override
  void onInit() {
    super.onInit();
  }

  final allTours = [
    {
      "_id": "66f44bc7c027e3f07c074664",
      "TOUR_NAME": "Khám Phá Vẻ Đẹp Đà Nẵng",
      "LOCATION": "Đà Nẵng",
      "PRICE_PER_PERSON": "1200000",
      "DESCRIPTION":
          "Tour du lịch Đà Nẵng đưa bạn đến với thành phố đáng sống nhất...",
      "IMAGES": [
        "https://bariavungtautourism.com.vn/wp-content/uploads/2023/12/tour-vung-tau-3-ngay-2-dem-1.jpg"
      ]
    },
    // Thêm các tour khác vào danh sách
  ];

  // void onSearch(String query) {
  //   searchText.value = query;
  //   if (query.isNotEmpty) {
  //     searchResults.value = allTours
  //         .where((tour) =>
  //             (tour['TOUR_NAME'] as String?)
  //                 ?.toLowerCase()
  //                 .contains(query.toLowerCase()) ??
  //             false)
  //         .toList();
  //   } else {
  //     searchResults.clear();
  //   }
  // }

  void clearSearch() {
    textController.clear(); // Xóa nội dung trong TextField
    searchText.value = '';
    searchResults.clear();
  }

  void onSearch(String query) async {
    searchText.value = query;
    final AuthenticationModel? authModel = await _getuserUseCase.getToken();

    if (authModel == null || authModel.metadata.isEmpty) {
      print("Error: Token is missing");
      return;
    }

    final String token = authModel.metadata;

    if (query.isNotEmpty) {
      final ApiService apiService = ApiService('http://10.0.2.2:3000', token);
      final String endpoint = "/tours/search?query=$query";

      try {
        print('Searching for: $query');
        final Map<String, dynamic> response = await apiService.getDataJSON(
          endpoint,
        );

        if (response['success'] == true) {
          searchResults.value = response['data'];
        } else {
          searchResults.clear();
          Get.snackbar('Thông báo', response['message']);
        }
      } catch (e) {
        searchResults.clear();
        Get.snackbar('Lỗi', 'Không thể tìm kiếm tour');
        print('Error: $e');
      }
    } else {
      searchResults.clear();
    }
  }
}
