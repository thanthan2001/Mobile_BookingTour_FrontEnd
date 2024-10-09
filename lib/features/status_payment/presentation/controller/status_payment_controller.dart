import 'package:get/get.dart';

import '../../../../core/services/api_service.dart';

class StatusPaymentController extends GetxController {
  final data = Get.arguments;
  String text = "";
  var response = {}.obs;
  @override
  void onInit() {
    super.onInit();
    String updatedData = data.toString().replaceAll("localhost", "10.0.2.2");
    print("Updated URL: $updatedData");
    fetchDataFromPaymentUrl(updatedData);
  }

  void fetchDataFromPaymentUrl(String fullUrl) async {
    final apiService =
        ApiService(''); // Base URL không quan trọng vì bạn truyền URL đầy đủ
    try {
      final responseData = await apiService.getDataFromUrl(fullUrl);
      response.value = responseData;
      text = response["msg"];
      print(response.values);
      print('Dữ liệu trả về: $responseData');
    } catch (e) {
      print('Lỗi khi gọi API: $e');
    }
  }
}
