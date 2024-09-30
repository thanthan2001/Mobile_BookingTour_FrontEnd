import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/button/elevated_button_widget.dart';
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
                  const SizedBox(height: 20),
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
                            Text(
                              '${controller.tourData['PRICE_PER_PERSON']} VND/Người' ??
                                  "1111", // Giá tour
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text(
                              controller.tourData['LOCATION'] ??
                                  "LOCATION NULL", // Địa điểm
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

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
                                style: GoogleFonts.poppins(
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
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),

                        const SizedBox(height: 16),
                        // Custom Attributes section (Khách sạn, Thức ăn, v.v.)
                        const SizedBox(height: 4),
                        Text(
                          'Khách sạn: ${controller.tourData['CUSTOM_ATTRIBUTES']['HOTEL']}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Text(
                          'Ăn uống: ${controller.tourData['CUSTOM_ATTRIBUTES']['RESTAURANT']}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Text(
                          // 'Hướng dẫn viên: ${controller.tourData['ID_TOUR_GUIDE_SUPERVISOR'].map((guide) => guide['FULLNAME']) // Ánh xạ qua từng guide và lấy FULLNAME
                          //     .join(', ')}',
                          // Nối tất cả các FULLNAME thành một chuỗi
                          "Địa điểm tham quan: ${controller.tourData['CUSTOM_ATTRIBUTES']['VISIT_PLACE'] // Ánh xạ qua từng địa điểm và lấy NAME
                              .join(', ')}",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),
                        // Preview section
                        Text(
                          'Đánh giá ',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        const SizedBox(height: 20),
                        // Available Slots section
                        Text(
                          'Cọc trước: ${controller.tourData['DEPOSIT_PERCENTAGE'].toString() + '%'}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     if (controller.tourData['IMAGES'] != null &&
          //         controller.tourData['IMAGES'].isNotEmpty)
          //       for (var image in controller
          //           .tourData['IMAGES']) // Lặp qua danh sách ảnh nếu tồn tại
          //         Container(
          //           width: 80,
          //           height: 80,
          //           margin: const EdgeInsets.symmetric(horizontal: 4),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             image: DecorationImage(
          //               image: NetworkImage(image),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         )
          //     else
          //       // Hiển thị một ảnh dự phòng khi không có ảnh nào
          //       Container(
          //         width: 80,
          //         height: 80,
          //         margin: const EdgeInsets.symmetric(horizontal: 4),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           color: Colors.grey[200], // Màu nền dự phòng
          //         ),
          //         child: const Center(
          //           child: Icon(Icons.image_not_supported, color: Colors.grey),
          //         ),
          //       ),
          //   ],
          // ),
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

          const SizedBox(height: 16), // Khoảng cách phía dưới nút

          // Phần nút "Đặt ngay"
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: IconButtonWidget(
                      backgroundColor: AppColors.gray,
                      ontap: () {},
                      icon: Icons.shopping_cart,
                      text: '',
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: ElevatedButtonWidget(
                    ontap: () {
                      // Thêm logic xử lý khi nhấn vào "Đặt ngay"
                    },
                    icon: '',
                    text: 'Đặt ngay',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
