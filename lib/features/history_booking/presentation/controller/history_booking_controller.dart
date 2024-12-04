import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class HistoryBookingController extends GetxController {
  List bookingData = [].obs;
  RxBool isLoading = true.obs;

  final GetuserUseCase _getuserUseCase;

  HistoryBookingController(this._getuserUseCase);

  @override
  void onInit() {
    fetchDataBooking();
    super.onInit();
  }

  String formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  Future<void> fetchDataBooking() async {
    final AuthenticationModel? authModel = await _getuserUseCase.getToken();
    if (authModel == null || authModel.metadata.isEmpty) {
      print("Error: Token is missing");
      return;
    }
    final String token = authModel.metadata;
    final apiService = ApiService("http://10.0.2.2:3000", token);
    final String endpoint = "/booking/my-booking";
    try {
      final response = await apiService.getDataJSON(endpoint);
      bookingData = response['data'];
      isLoading.value = false;
      print(response["data"]);
    } catch (e) {
      print("Error: $e");
    }
  }
}
