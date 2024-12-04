import 'package:get/get.dart';
import 'package:reading_app/core/services/api_service.dart';

import '../../../../core/services/models/authentication_model.dart';
import '../../../auth/user/domain/use_case/get_user_use_case.dart';

class InforPaymentController extends GetxController {
  final GetuserUseCase _getuserUseCase;

  var fullName = ''.obs;
  var citizen = ''.obs;
  var phoneNumber = ''.obs;
  var dataPayment = Get.arguments;
  var ListDataTour = Get.arguments;
  var fullNameError = ''.obs;
  var citizenError = ''.obs;
  var phoneNumberError = ''.obs;
  InforPaymentController(this._getuserUseCase);
  @override
  void onInit() {
    print("Data Payment: $dataPayment");
    print("List Data Tour: $ListDataTour");
    super.onInit();
  }

  bool _validateFields() {
    bool isValid = true;

    // Validate Họ và Tên
    if (fullName.value.isEmpty) {
      fullNameError.value = 'Vui lòng nhập Họ và Tên';
      isValid = false;
    } else {
      fullNameError.value = '';
    }

    // Validate Số CMND/CCCD
    if (citizen.value.isEmpty) {
      citizenError.value = 'Vui lòng nhập CMND/CCCD';
      isValid = false;
    } else {
      citizenError.value = '';
    }

    // Validate Số điện thoại
    if (phoneNumber.value.isEmpty || phoneNumber.value.length < 10) {
      phoneNumberError.value = 'Vui lòng nhập số điện thoại hợp lệ';
      isValid = false;
    } else {
      phoneNumberError.value = '';
    }

    return isValid;
  }

  Future<void> hanlePayment() async {
    if (_validateFields()) {
      print('Thanh toán thành công');
      final AuthenticationModel? authModel = await _getuserUseCase.getToken();
      if (authModel == null || authModel.metadata.isEmpty) {
        print("Error: Token is missing");
        return;
      }

      final String token = authModel.metadata;
      final apiService = ApiService("http://10.0.2.2:3000", token);
      final totalPrice = dataPayment
          .map((e) => e['TOTAL_PRICE_TOUR'] ?? 0)
          .reduce((a, b) => a + b);
      final dataBooking = {
        "toursDetails": ListDataTour, // Thông tin tour
        "CUSTOMER_PHONE": phoneNumber.value, // Thông tin khách hàng
        "CUSTOMER_NAME": fullName.value,
        "CITIZEN_ID": citizen.value,
        "bookingType": "Online",
        "TOTAL_PRICE": totalPrice,
      };
      print("Data Booking: $dataBooking");
      final String endpoint = "/booking/booking-nows";
      try {
        final response = await apiService.postData(endpoint, dataBooking);
        print(response);
        final TOTAL_PRICE = response['data']['TOTAL_PRICE'];
        final Booking_ID = response['data']['_id'];

        final dataPaymentVNPay = {"id": Booking_ID, "totalPrice": TOTAL_PRICE};
        print(dataPaymentVNPay);
        try {
          final apiService = ApiService("http://10.0.2.2:3000", token);

          final String endpoint = "//payments/create-payment";
          final responsePayment =
              await apiService.postData(endpoint, dataPaymentVNPay);
          print(responsePayment);
          final URL_PAYMENT = responsePayment['data']['url'];
          Get.toNamed('/payment-vnpay', arguments: URL_PAYMENT);
        } catch (e) {
          print(e);
        }
        print(response);
      } catch (e) {
        print(e);
      }
    } else {
      print('Có lỗi trong quá trình nhập liệu');
    }
  }
}
