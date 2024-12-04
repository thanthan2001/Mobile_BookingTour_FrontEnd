import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Thêm thư viện intl
import 'package:reading_app/core/configs/const/enum.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/dialogs/dialogs.dart';
import 'package:reading_app/core/ui/widgets/customs/button/button_normal.dart';
import 'package:reading_app/features/cart/presentation/controller/cart_controller.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.cartTour.isEmpty ||
                  controller.cartTour['LIST_TOUR_REF'] == []) {
                return const Center(
                    child: Text('Bạn chưa có Tour trong giỏ hàng!'));
              } else {
                final List<dynamic> listTourRef =
                    controller.cartTour['LIST_TOUR_REF'];
                if (listTourRef.isEmpty) {
                  return const Center(
                      child: Text('Bạn chưa có Tour trong giỏ hàng!'));
                }

                return ListView.builder(
                  itemCount: listTourRef.length,
                  itemBuilder: (context, index) {
                    if (index >= listTourRef.length) {
                      return const SizedBox
                          .shrink(); // Trả về widget trống nếu index không hợp lệ
                    }

                    final tourData = listTourRef[index]['TOUR_ID'];
                    final startDate = DateFormat('dd/MM/yyyy').format(
                        DateTime.parse(listTourRef[index]['START_DATE']));
                    final endDate = DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(listTourRef[index]['END_DATE']));
                    final startTime = listTourRef[index]['START_TIME'];

                    // Kiểm tra xem mảng IMAGES có phần tử hay không
                    final imageUrl = tourData['IMAGES'] != null &&
                            tourData['IMAGES'].isNotEmpty
                        ? tourData['IMAGES'][1]
                        : 'https://via.placeholder.com/100'; // URL ảnh thay thế nếu không có ảnh

                    return Slidable(
                      key: ValueKey(tourData['_id']),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) => {
                              DialogsUtils.showAlertDialog2(
                                  title: 'Xóa tour khỏi giỏ hàng?',
                                  message:
                                      'Bạn sẽ không thể hoàn tác hành động này',
                                  typeDialog: TypeDialog.error,
                                  onPresss: () {
                                    final tourID = tourData['_id'];
                                    print(tourID);
                                    controller.hanleDeleteItemCart(tourID);
                                  })
                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Xóa',
                          ),
                          SlidableAction(
                            onPressed: (_) =>
                                _showEditBottomSheet(context, tourData, index),
                            backgroundColor: Color(0xff2BA491),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Chỉnh sửa',
                          ),
                        ],
                      ),
                      child: _buildItemCartData(
                        imageUrl: imageUrl, // Kiểm tra và dùng ảnh đầu tiên
                        title: tourData['TOUR_NAME'], // Tên tour
                        location: tourData['LOCATION'], // Vị trí
                        startDate: startDate,
                        endDate: endDate,
                        startTime: startTime,
                        price: tourData['PRICE_PER_PERSON'].toString(), // Giá
                        tourData: tourData,
                        index: index,
                        isChecked: false,
                        slot: listTourRef[index]["NUMBER_OF_PEOPLE"].toString(),
                        // tourData[
                        //     "NUMBER_OF_PEOPLE"], // Sử dụng để quản lý trạng thái của checkbox
                      ),
                    );
                  },
                );
              }
            }),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    "Tổng tiền: ${controller.formatCurrency(controller.totalPrice.value.toString())}",
                    style: GoogleFonts.roboto(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ButtonNormal(
                    textChild: "Thanh toán",
                    onTap: () async {
                      if (controller.cartTour['LIST_TOUR_REF'] == null ||
                          controller.cartTour['LIST_TOUR_REF'].isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Thông báo'),
                            content: Text('Giỏ hàng của bạn đang trống'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Đồng ý'),
                              ),
                            ],
                          ),
                        );
                        return;
                      }

                      if (controller.selectedTours.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Thông báo'),
                            content: Text('Vui lòng chọn tour cần thanh toán'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Đồng ý'),
                              ),
                            ],
                          ),
                        );
                        return;
                      }

                      // Kiểm tra các ngày bắt đầu của các tour được chọn
                      final startDates = controller.selectedTours
                          .map((tour) => tour['START_DATE'])
                          .toList();
                      final hasDuplicateStartDate =
                          startDates.toSet().length != startDates.length;

                      if (hasDuplicateStartDate) {
                        // Nếu có nhiều tour có cùng ngày bắt đầu, hiển thị dialog xác nhận
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 8),
                                Text('Cảnh báo'),
                              ],
                            ),
                            content: const Text(
                                'Bạn đã chọn nhiều tour có cùng ngày khởi hành. Bạn có chắc chắn muốn tiếp tục không?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Đóng dialog
                                },
                                child: const Text('Hủy'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop(); // Đóng dialog
                                  await controller.handlePaymentCart();
                                },
                                child: Text('Đồng ý',
                                    style: TextStyle(color: AppColors.red)),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Nếu không có ngày khởi hành trùng nhau, chuyển đến thanh toán
                        await controller.handlePaymentCart();
                      }
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildItemCartData({
    required String? imageUrl,
    required String title,
    required String location,
    required String startDate,
    required String endDate,
    required String startTime,
    required String price,
    required String slot,
    required int index,
    required Map<String, dynamic> tourData,
    required bool isChecked,
  }) {
    return InkWell(
      onTap: () {
        print(tourData);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                return Checkbox(
                  value: controller.cartTour['LIST_TOUR_REF'][index]
                      ['isChecked'], // Lấy giá trị isChecked từ cartTour
                  onChanged: (value) {
                    controller.updateItemCheckStatus(index,
                        value!); // Cập nhật trạng thái khi người dùng thay đổi
                  },

                  activeColor: Colors.blue, // Màu khi checkbox được chọn
                  checkColor: Colors.white, // Màu của dấu tích khi được chọn
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5), // Bo góc của checkbox
                  ),
                  side: const BorderSide(
                    color: Colors.white, // Viền checkbox
                    width: 2,
                  ),
                );
              }),
            ),
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl ?? "https://via.placeholder.com/100",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey,
                      child: const Center(
                        child: Text(
                          'Image not available',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.roboto(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: Colors.blueAccent),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Ngày: $startDate - $endDate",
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Giờ khởi hành: $startTime",
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  Text("Số vé: $slot",
                      style: GoogleFonts.poppins(
                        fontSize: 12.0,
                        color: Colors.grey,
                      )),
                  Text(
                    controller.formatCurrency(price.toString()),
                    style: GoogleFonts.roboto(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditBottomSheet(
      BuildContext context, Map<String, dynamic> tourData, int index) {
    final List<dynamic> calendarTour = tourData['CALENDAR_TOUR'];

    // Đặt giá trị mặc định cho selectedDate và selectedPeople từ controller
    controller.selectedDate.value = calendarTour[0]['START_DATE'];
    controller.startTime.value = calendarTour[0]['START_TIME'];
    controller.numberOfPeople.value = int.parse(controller
        .cartTour['LIST_TOUR_REF'][index]["NUMBER_OF_PEOPLE"]
        .toString()); // Lấy số lượng người từ cart
// Lấy NumberOfDay để tính ngày về
    final int numberOfDay = calendarTour[0]['NumberOfDay'];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép cuộn nếu nội dung dài
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Hiển thị ảnh
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  tourData['IMAGES'] != null && tourData['IMAGES'].isNotEmpty
                      ? tourData['IMAGES'][1]
                      : 'https://via.placeholder.com/100',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Hiển thị tên tour
              Text(
                tourData['TOUR_NAME'],
                style: GoogleFonts.roboto(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Dropdown chọn ngày bắt đầu từ CALENDAR_TOUR
              Row(
                children: [
                  const Expanded(flex: 3, child: Text("Ngày khởi hành: ")),
                  Expanded(
                    flex: 6,
                    child: Obx(() {
                      return DropdownButton<String>(
                        isExpanded: true,
                        value: controller.selectedDate.value,
                        items: calendarTour.map((date) {
                          final startDate = DateFormat('dd/MM/yyyy')
                              .format(DateTime.parse(date['START_DATE']));
                          return DropdownMenuItem<String>(
                            value: date['START_DATE'],
                            child: Text(startDate),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedDate.value = value!;

                          // Cập nhật START_TIME khi chọn ngày mới
                          final selectedTour = calendarTour.firstWhere(
                            (tour) => tour['START_DATE'] == value,
                            orElse: () => calendarTour[0],
                          );
                          controller.startTime.value =
                              selectedTour['START_TIME'];
                        },
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Hiển thị START_TIME
              Obx(() {
                return Text(
                  'Giờ khởi hành: ${controller.startTime.value}',
                  style: GoogleFonts.roboto(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                );
              }),
              const SizedBox(height: 16),

              Obx(() {
                final DateTime startDate =
                    DateTime.parse(controller.selectedDate.value);
                final DateTime endDate =
                    startDate.add(Duration(days: numberOfDay));

                final String formattedEndDate =
                    DateFormat('dd/MM/yyyy').format(endDate);

                return Text(
                  'Ngày về: $formattedEndDate',
                  style: GoogleFonts.roboto(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                );
              }),
              const SizedBox(height: 16),

              // Nhập số lượng người
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Số người:'),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (controller.numberOfPeople.value > 1) {
                        controller.numberOfPeople.value--;
                      }
                    },
                  ),
                  Obx(() => Text('${controller.numberOfPeople.value}')),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      controller.numberOfPeople.value++;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Nút xác nhận chỉnh sửa
              ButtonNormal(
                textChild: "Xác nhận",
                onTap: () async {
                  // Tạo object chứa thông tin cập nhật
                  final Map<String, dynamic> updatedData = {
                    "cartId": controller.cartTour['_id'], // ID của giỏ hàng

                    "tourId": tourData['_id'], // ID của tour
                    "CALENDAR_TOUR_ID": calendarTour.firstWhere((tour) =>
                        tour['START_DATE'] ==
                        controller.selectedDate.value)['_id'],
                    "START_DATE": controller.selectedDate.value, // Ngày đã chọn
                    "END_DATE": calendarTour.firstWhere((tour) =>
                        tour['START_DATE'] ==
                        controller.selectedDate.value)['END_DATE'],
                    "START_TIME": controller.startTime.value,
                    "TOTAL_PRICE_TOUR": controller.totalPrice.value *
                        double.parse(controller.cartTour['LIST_TOUR_REF'][index]
                            [
                            'NUMBER_OF_PEOPLE']), // Thời gian bắt đầu từ calendar tour
                    "NUMBER_OF_PEOPLE":
                        controller.numberOfPeople.value, // Số người đã chọn
                  };

                  print(updatedData);
                  await controller.handleUpdateItemCart(updatedData);
                  // Đóng BottomSheet
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
