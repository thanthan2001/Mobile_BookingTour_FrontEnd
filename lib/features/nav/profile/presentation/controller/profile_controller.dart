import 'dart:io';

import 'package:get/get.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/core/services/models/infor_model.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final Prefs _prefs = Prefs();
  final GetuserUseCase _getuserUseCase;
  final ImagePicker _picker = ImagePicker();
  var user = Rx<InforModel?>(null); // Sử dụng Rx<InforModel?>
  late AuthenticationModel? authModel;
  ProfileController(this._getuserUseCase);
  var dataUser = {}.obs;
  @override
  void onInit() async {
    await loadUserInfo();
    await loadUserInfo();
    print("user infor ${user.value.toString()}");
    super.onInit();
  }

  Future<void> logout() async {
    await _prefs.clear();
    Get.offAllNamed('/login');
  }

  Future<void> loadDataUser() async {
    authModel = await _getuserUseCase.getToken();
    final String token = authModel!.metadata;
    if (authModel == null || authModel!.metadata.isEmpty) {
      print("Error: Token is missing");
      return;
    }
  }

  Future<void> loadUserInfo() async {
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
      // print("dhsajdhasjid $response");
      dataUser.value = response;
      print("Data user: $dataUser");
    } catch (e) {
      print(e);
    }
  }

  // Hàm chọn ảnh và gọi API đổi `PHOTO_URL`
  Future<void> pickAndUploadImage() async {
    authModel = await _getuserUseCase.getToken();
    final String token = authModel!.metadata;
    if (authModel == null || authModel!.metadata.isEmpty) {
      print("Error: Token is missing");
      return;
    }
    print(token);
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    final ApiService apiService =
        ApiService('http://10.0.2.2:3000'); // Thay baseUrl của bạn
    if (image != null) {
      final result = await apiService.uploadPhoto(File(image.path), token);
      if (result['success']) {
        print("Upload thành công: ${result['data']}");
      } else {
        print("Lỗi khi upload ảnh: ${result['error']}");
      }
    }
  }
  // Gọi API để upload ảnh và lấy URL mới
  // Future<String?> _uploadImage(File imageFile) async {
  //   try {
  //     final response = await ApiService.uploadPhoto(imageFile); // Gọi API upload ảnh
  //     if (response['success']) {
  //       return response['data']['photoUrl']; // URL ảnh mới
  //     }
  //   } catch (e) {
  //     print("Error uploading image: $e");
  //   }
  //   return null;
  // }
}
