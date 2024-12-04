import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class DetailBookingController extends GetxController {
  late String bookingId = Get.arguments;
  final GetuserUseCase _getuserUseCase;
  var dataBooking = {}.obs;
  DetailBookingController(this._getuserUseCase);
  @override
  void onInit() async {
    this.bookingId = Get.arguments;
    print("Booking IDzz: $bookingId");
    await fetchDataBooking();
    super.onInit();
  }

  String formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(parsedDate);
  }

  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    // Sử dụng `double.tryParse` để chuyển chuỗi thành số, trả về 0 nếu chuyển đổi không thành công
    final doublePrice = double.tryParse(price) ?? 0.0;
    return formatter.format(doublePrice);
  }

  Future<void> fetchDataBooking() async {
    try {
      final AuthenticationModel? authModel = await _getuserUseCase.getToken();

      if (authModel == null || authModel.metadata.isEmpty) {
        print("MISSING TOKEN");
        return;
      }

      final String token = authModel.metadata;
      final apiService = ApiService("http://10.0.2.2:3000", token);
      final String endpoint = "/booking/booking-by-id/$bookingId";
      final response = await apiService.getDataJSON(endpoint);
      dataBooking.value = response["data"];
      print("Data Booking: $dataBooking");
    } catch (e) {
      print("Error: $e");
    }
  }
}
