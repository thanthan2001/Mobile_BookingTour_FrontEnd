import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/button/elevated_button_widget.dart';
import 'package:reading_app/core/ui/widgets/customs/inputs/input_app_normal.dart';
import 'package:reading_app/core/ui/widgets/icons/icon_circle.dart';
import 'package:reading_app/features/detail_tour/presentation/controller/detail_tour_controller.dart';
import 'package:reading_app/features/detail_tour/presentation/widgets/icon_button.dart';
import 'package:reading_app/features/detail_tour/presentation/widgets/icon_button2.dart';

class DetailTourPage extends GetView<DetailTourController> {
  const DetailTourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: AppColors.white,
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back(); // Quay lại trang trước
          },
        ),
        actions: [
          Obx(() => IconButton(
                highlightColor: AppColors.primary.withOpacity(0.4),
                icon: controller.isFavorite.value
                    ? const Icon(Icons.favorite, color: Colors.red)
                    : const Icon(Icons.favorite_border),
                onPressed: () {
                  controller.toggleFavorite(); // Thay đổi trạng thái khi nhấn
                },
              )),
        ],
      ),
      extendBodyBehindAppBar: true, // Để làm nền transparent
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Phần nội dung cuộn
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        // Mở ảnh lớn khi nhấn vào Stack
                        controller.openImageDialog(
                            context, controller.currentImage.value);
                      },
                      child: Stack(
                        children: [
                          // Image section
                          Image.network(
                            controller.currentImage.value ??
                                "https://via.placeholder.com/100", // URL của ảnh chính từ dữ liệu
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Title and Price section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 3,
                              controller.tourData['TOUR_NAME'] ??
                                  "null", // Tên tour
                              style: GoogleFonts.roboto(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              controller.formatCurrency(
                                  controller.tourData['PRICE_PER_PERSON']),
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),

                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text(
                              controller.tourData['LOCATION'] ??
                                  "LOCATION NULL", // Địa điểm
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),

                        // Mô tả tour với "Xem thêm"
                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.tourData['DESCRIPTION'] ??
                                    "DESCRIPTION NULL", // Mô tả tour
                                maxLines: controller.isExpanded.value
                                    ? 100
                                    : 5, // Hiển thị đầy đủ khi mở rộng
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller
                                      .toggleDescription(); // Thay đổi trạng thái mở rộng
                                },
                                child: Text(
                                  controller.isExpanded.value
                                      ? 'Thu gọn'
                                      : 'Xem thêm', // Hiển thị "Thu gọn" hoặc "Xem thêm"
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        const SizedBox(height: 5),
                        Text(
                          'Nơi khởi hành : ${controller.tourData["START_ADDRESS"]} ',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),

                        Text(
                          'Khách sạn: ${controller.tourData['CUSTOM_ATTRIBUTES']['HOTEL']}',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),

                        Text(
                          'Ăn uống: ${controller.tourData['CUSTOM_ATTRIBUTES']['RESTAURANT']}',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),

                        Text(
                          // 'Hướng dẫn viên: ${controller.tourData['ID_TOUR_GUIDE_SUPERVISOR'].map((guide) => guide['FULLNAME']) // Ánh xạ qua từng guide và lấy FULLNAME
                          //     .join(', ')}',
                          // Nối tất cả các FULLNAME thành một chuỗi
                          "Địa điểm tham quan: ${controller.tourData['CUSTOM_ATTRIBUTES']['VISIT_PLACE'] // Ánh xạ qua từng địa điểm và lấy NAME
                              .join(', ')}",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),

                        Text(
                          'Hướng dẫn viên: ${controller.tourData['ID_TOUR_GUIDE_SUPERVISOR'].map((guide) => guide['FULLNAME']) // Ánh xạ qua từng guide và lấy FULLNAME
                              .join(', ')}',
                          // Nối tất cả các FULLNAME thành một chuỗi
                          // "Địa điểm tham quan: ${controller.tourData['CUSTOM_ATTRIBUTES']['VISIT_PLACE'] // Ánh xạ qua từng địa điểm và lấy NAME
                          //     .join(', ')}",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),

                        Text(
                          'Phương tiện : ${controller.tourData["VEHICLE"]} ',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),

                        Text(
                          'Dịch vụ: ${controller.tourData["CUSTOM_ATTRIBUTES"]["VEHICLE_PERSENAL"]} ',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),

                        // Text(
                        //   'Cọc trước: ${controller.tourData['DEPOSIT_PERCENTAGE'].toString() + '%'}',
                        //   style: GoogleFonts.roboto(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        Text(
                          'Ghi chú:\n${controller.tourData["CUSTOM_ATTRIBUTES"]["NOTE"]?.replaceAll('.', '.\n') ?? "jajaj"}',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text("Đánh giá",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  // Text(
                  //   'Comments',
                  //   style: GoogleFonts.roboto(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.commentText,
                            decoration: const InputDecoration(
                              hintText: 'Nhập bình luận',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: Colors.blue),
                          onPressed: () async {
                            await controller.submitComment();
                            controller.commentText.clear();
                          },
                        ),
                      ],
                    ),
                  ),

                  _buildCommentsSection(),
                ],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (controller.images.isNotEmpty)
                for (var image in controller.images)
                  GestureDetector(
                    onTap: () {
                      // Gọi phương thức changeImage để cập nhật ảnh chính
                      controller.changeImage(image);
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(image.toString()),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
              else
                // Hiển thị một ảnh dự phòng khi không có ảnh nào
                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200], // Màu nền dự phòng
                  ),
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                ),
            ],
          ),

          // Phần nút "Đặt ngay"
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                addToCartButton(context),
                const SizedBox(
                  width: 10,
                ),
                BookingNowButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded addToCartButton(BuildContext context) {
    return Expanded(
        flex: 1,
        child: ElevatedButtonWidget(
          // backgroundColor: AppColors.gray,
          ontap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // Cho phép cuộn khi cần thiết
              builder: (BuildContext context) {
                return DraggableScrollableSheet(
                  expand: false,
                  builder: (context, scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize
                              .min, // Đảm bảo cột chiếm không gian tối thiểu cần thiết
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.network(
                                    controller.currentImage.value,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.tourData['TOUR_NAME'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          controller.formatCurrency(controller
                                              .tourData['PRICE_PER_PERSON']),
                                          style: GoogleFonts.roboto(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Chọn ngày đi',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(() {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 5),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: controller.selectedDate.value,
                                          icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.blue),
                                          iconSize: 30,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          dropdownColor: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          isExpanded: true,
                                          onChanged: (String? newValue) {
                                            int index = controller.calendarTour
                                                .indexWhere(
                                              (tour) =>
                                                  controller.formatDate(
                                                      tour['START_DATE']) ==
                                                  newValue,
                                            );
                                            if (index != -1) {
                                              controller.updateTourInfo(index);
                                            }
                                          },
                                          items: controller
                                              .getUpcomingDates()
                                              .map<DropdownMenuItem<String>>(
                                            (dynamic value) {
                                              String formattedDate =
                                                  controller.formatDate(
                                                      value['START_DATE']);
                                              return DropdownMenuItem<String>(
                                                value: formattedDate,
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.calendar_today,
                                                        color: Colors.blue,
                                                        size: 20),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      formattedDate,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Obx(() {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Số lượng slot còn: ${controller.availableSlots}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Giờ khởi hành: ${controller.startTime}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Ngày về: ${controller.endDate}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            }),
                            const SizedBox(height: 10),
                            Obx(() {
                              return Row(
                                children: [
                                  const Text(
                                    'Số lượng người',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: controller.decreasePeople,
                                        icon: const Icon(Icons.remove),
                                        color: Colors.red,
                                      ),
                                      Text(
                                        '${controller.numberOfPeople.value}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: controller.increasePeople,
                                        icon: const Icon(Icons.add),
                                        color: Colors.green,
                                      ),
                                    ],
                                  )
                                ],
                              );
                            }),
                            const SizedBox(height: 5),
                            const Text(
                              'Tổng tiền',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Obx(() {
                              return Text(
                                controller.formatCurrency(
                                    controller.totalPrice.value.toString()),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                            const SizedBox(height: 20),
                            ElevatedButtonWidget(
                              ontap: () async {
                                print("ADD TO CARTTTTTTTTTTTTTTTTTTTTT");
                                await controller.addToCart();
                              },
                              text: 'Thêm vào giỏ hàng',
                              icon: '',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          icon: AppImages.icShoppingCart,
          text: '',
        ));
  }

  Expanded BookingNowButton(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ElevatedButtonWidget(
        ontap: () {
          // Gọi phương thức để mở BottomSheet
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Cho phép cuộn khi cần thiết
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                expand: false,
                builder: (context, scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize
                            .min, // Đảm bảo cột chiếm không gian tối thiểu cần thiết
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.network(
                                  controller.currentImage.value,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.tourData['TOUR_NAME'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${controller.tourData['PRICE_PER_PERSON']} VND/Người',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Chọn ngày đi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: controller.selectedDate.value,
                                        icon: const Icon(Icons.arrow_drop_down,
                                            color: Colors.blue),
                                        iconSize: 30,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        dropdownColor: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        isExpanded: true,
                                        onChanged: (String? newValue) {
                                          int index = controller.calendarTour
                                              .indexWhere(
                                            (tour) =>
                                                controller.formatDate(
                                                    tour['START_DATE']) ==
                                                newValue,
                                          );
                                          if (index != -1) {
                                            controller.updateTourInfo(index);
                                          }
                                        },
                                        items: controller.calendarTour
                                            .map<DropdownMenuItem<String>>(
                                          (dynamic value) {
                                            String formattedDate =
                                                controller.formatDate(
                                                    value['START_DATE']);
                                            return DropdownMenuItem<String>(
                                              value: formattedDate,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.calendar_today,
                                                      color: Colors.blue,
                                                      size: 20),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    formattedDate,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Số lượng slot còn: ${controller.availableSlots}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Giờ khởi hành: ${controller.startTime}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Ngày về: ${controller.endDate}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          }),
                          const SizedBox(height: 10),
                          Obx(() {
                            return Row(
                              children: [
                                const Text(
                                  'Số lượng người',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: controller.decreasePeople,
                                      icon: const Icon(Icons.remove),
                                      color: Colors.red,
                                    ),
                                    Text(
                                      '${controller.numberOfPeople.value}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: controller.increasePeople,
                                      icon: const Icon(Icons.add),
                                      color: Colors.green,
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                          const SizedBox(height: 5),
                          const Text(
                            'Tổng tiền',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(() {
                            return Text(
                              '${controller.totalPrice.value} VND',
                              style: const TextStyle(
                                fontSize: 20,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                          ElevatedButtonWidget(
                            ontap: () async {
                              await controller.handleBookingNow();
                            },
                            text: 'Xác nhận đặt Tour',
                            icon: '',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        icon: '',
        text: 'Đặt ngay',
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Obx(() => Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 0, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Column(
                children: controller.commentTour
                    .where((comment) =>
                        comment['STATUS'] ==
                        true) // Lọc comment với STATUS = true
                    .map((comment) {
                  return _buildCommentItem(comment);
                }).toList(),
              ),
            ],
          ),
        ));
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment['USER_ID']['FULLNAME'] ?? 'Anonymous',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            comment['COMMENT'] ?? '',
            style: GoogleFonts.roboto(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
