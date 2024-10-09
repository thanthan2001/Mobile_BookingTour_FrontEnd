import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Thêm thư viện intl
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/customs/button/button_normal.dart';
import 'package:reading_app/features/cart/presentation/controller/cart_controller.dart';

class CartPage extends GetView<CartController> {
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
              if (controller.cartTour.isEmpty) {
                return const Center(
                    child: Text('Bạn chưa có Tour trong giỏ hàng!'));
              } else {
                final List<dynamic> listTourRef =
                    controller.cartTour['LIST_TOUR_REF'];
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
                            onPressed: (_) =>
                                controller.removeFromCart(tourData),
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (_) =>
                                controller.removeFromCart(tourData),
                            backgroundColor: Color(0xff2BA491),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
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
                    "Tổng tiền: ${controller.totalPrice.value} VND",
                    style: GoogleFonts.roboto(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ButtonNormal(
                    textChild: "Thanh toán",
                    onTap: () {
                      print("THANH TOÁN");
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
                  side: BorderSide(
                    color: Colors.grey, // Viền checkbox
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
                    "$price VND/Người",
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
}
