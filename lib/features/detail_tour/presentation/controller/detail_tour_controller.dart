import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/core/ui/widgets/button/elevated_button_widget.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class DetailTourController extends GetxController {
  final GetuserUseCase _getuserUseCase;

  late Map<String, dynamic> tourData;
  var numberOfPeople = 1.obs;
  var selectedItem = 0.obs;
  var isFavorite = false.obs;
  var isExpanded = false.obs;
  List<dynamic> calendarTour = []; // Danh sách ngày trong tour
  List<String> images = [];
  var currentImage = "".obs;
  var selectedDate = ''.obs; // Ngày được chọn từ dropdown
  var availableSlots = 0.obs; // Lưu trữ số lượng slot
  var startTime = ''.obs; // Lưu trữ thời gian bắt đầu
  var endDate = ''.obs;
  var totalPrice = 0.obs; // Lưu trữ ngày về dựa trên NumberOfDay

  DetailTourController(this._getuserUseCase);
  @override
  void onInit() {
    super.onInit();
    tourData = Get.arguments ?? {};

    // Lấy danh sách ảnh và set giá trị hình ảnh hiện tại
    images = List<String>.from(tourData['IMAGES'] ?? []);
    currentImage.value = images.isNotEmpty ? images[0] : '';

    // Lấy danh sách ngày từ CALENDAR_TOUR và set ngày được chọn mặc định
    calendarTour = List<dynamic>.from(tourData['CALENDAR_TOUR'] ?? []);
    if (calendarTour.isNotEmpty) {
      selectedDate.value = formatDate(calendarTour[0]['START_DATE']).toString();
      this.calendarTour = calendarTour;
    }

    totalPrice.value =
        int.parse(tourData['PRICE_PER_PERSON']) * numberOfPeople.value;
  }

  // Cập nhật tổng tiền khi số lượng người thay đổi
  void updateTotalPrice() {
    totalPrice.value =
        int.parse(tourData['PRICE_PER_PERSON']) * numberOfPeople.value;
  } // Hàm tăng số lượng người

  void increasePeople() {
    if (numberOfPeople.value < availableSlots.value) {
      numberOfPeople.value++;
      updateTotalPrice();
    }
  }

  // Hàm giảm số lượng người
  void decreasePeople() {
    if (numberOfPeople.value > 1) {
      numberOfPeople.value--;
      updateTotalPrice();
    }
  }

  // Chuyển đổi ngày từ định dạng ISO thành định dạng dd/MM/yyyy
  String formatDate(String isoDate) {
    DateTime date = DateTime.parse(isoDate);
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Toggle description expansion
  void toggleDescription() {
    isExpanded.value = !isExpanded.value; // Đổi giữa true và false
  }

  // Toggle favorite state
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  // Change current image
  void changeImage(String newImage) {
    currentImage.value = newImage;
  }

  // Handle image dialog
  void openImageDialog(BuildContext context, String imageUrl) {
    openFullScreenImageDialog(context, imageUrl);
  }

  void openFullScreenImageDialog(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Center(
            child: Image.network(
              imageUrl,
              fit: BoxFit
                  .contain, // Hiển thị ảnh ở chế độ contain để xem chi tiết
            ),
          ),
        ),
        fullscreenDialog: true, // Hiển thị ở chế độ toàn màn hình
      ),
    );
  }

  // Handle selecting a date from the tour's calendar
  void selectDate(int index) {
    selectedDate.value = formatDate(calendarTour[index]['START_DATE']);
  }

  // Tính toán ngày kết thúc dựa trên số ngày
  String calculateEndDate(String startDate, int numberOfDay) {
    DateTime start = DateTime.parse(startDate);
    DateTime end = start.add(Duration(days: numberOfDay));
    return formatDate(end.toIso8601String());
  }

  void updateTourInfo(int index) {
    selectedDate.value = formatDate(calendarTour[index]['START_DATE']);
    availableSlots.value = calendarTour[index]['AVAILABLE_SLOTS'];
    startTime.value = calendarTour[index]['START_TIME']; // Cập nhật startTime
    endDate.value = calculateEndDate(
      calendarTour[index]['START_DATE'],
      calendarTour[index]['NumberOfDay'],
    ); // Cập nhật endDate
  }

  Future<void> addToCart() async {
    final AuthenticationModel? authModel = await _getuserUseCase.getToken();

    if (authModel == null || authModel.metadata.isEmpty) {
      print("Error: Token is missing");
      return;
    }
    final String token = authModel.metadata;

    // Khởi tạo ApiService với token lấy được
    final apiService = ApiService("http://10.0.2.2:3000", token);
    final String endpoint = "/carts/addTourToCart";

    final data = {
      "TOUR_ID": tourData['_id'],
      "START_DATE": selectedDate.value.isNotEmpty ? selectedDate.value : 'N/A',
      "END_DATE": endDate.value.isNotEmpty ? endDate.value : 'N/A',
      "NUMBER_OF_PEOPLE": numberOfPeople.value,
      "START_TIME": startTime.value.isNotEmpty ? startTime.value : 'N/A',
      "CALENDAR_TOUR_ID": calendarTour[selectedItem.value]['_id'],
      "TOTAL_PRICE_TOUR": totalPrice.value,
    };

    try {
      final response = await apiService.postData(endpoint, data);
      if (response["success"] == false) {
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Làm bo tròn các góc
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.warning_amber, // Biểu tượng thông báo
                  color: Colors.orange, // Màu của biểu tượng
                ),
                SizedBox(width: 10), // Khoảng cách giữa icon và title
                Text(
                  'Thông báo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87, // Màu chữ của tiêu đề
                  ),
                ),
              ],
            ),
            content: Text(
              response['message'],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54, // Màu chữ của nội dung
              ),
            ),
            actions: [
              ElevatedButtonWidget(
                ontap: () {
                  Navigator.of(Get.overlayContext!).pop();
                  Get.back();
                },
                icon: '',
                text: 'OK',
              ),
            ],
          ),
        );
      }
      if (response["success"] == true) {
        Get.dialog(
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Làm bo tròn các góc
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.info_outline, // Biểu tượng thông báo
                  color: Colors.blue, // Màu của biểu tượng
                ),
                SizedBox(width: 10), // Khoảng cách giữa icon và title
                Text(
                  'Thông báo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87, // Màu chữ của tiêu đề
                  ),
                ),
              ],
            ),
            content: Text(
              response['data']["message"],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54, // Màu chữ của nội dung
              ),
            ),
            actions: [
              ElevatedButtonWidget(
                ontap: () {
                  Navigator.of(Get.overlayContext!).pop();
                  Get.back();
                },
                icon: '',
                text: 'OK',
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> handleBookingNow() async {
    final totalPrice = this.totalPrice.value;
    final starDate = selectedDate.value.isNotEmpty ? selectedDate.value : 'N/A';
    final endDate = this.endDate.value.isNotEmpty ? this.endDate.value : 'N/A';
    final tourID = tourData['_id'] ?? 'N/A';
    final startTime =
        this.startTime.value.isNotEmpty ? this.startTime.value : 'N/A';
    final numberOfPeople = this.numberOfPeople.value;
    final CalendarTourID = calendarTour[selectedItem.value]['_id'];

    // Chuyển đổi ngày về định dạng yyyy-MM-dd
    String formatDateToYYYYMMDD(String date) {
      DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    }

    final data = [
      {
        "TOTAL_PRICE_TOUR": totalPrice,
        "TOUR_ID": tourID,
        "START_DATE": formatDateToYYYYMMDD(starDate),
        "END_DATE": formatDateToYYYYMMDD(endDate),
        "START_TIME": startTime,
        "SLOT": numberOfPeople,
        "CALENDAR_TOUR_ID": CalendarTourID,
      },
    ];
    Get.toNamed('/info-payment', arguments: data);
  }
}
