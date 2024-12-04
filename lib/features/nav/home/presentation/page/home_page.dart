import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/features/nav/home/presentation/controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Section
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Loại hình du lịch",
              //       style: GoogleFonts.poppins(
              //           fontSize: 18, fontWeight: FontWeight.bold),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         // Xử lý sự kiện khi click vào nút "View all"
              //         print("View all");
              //       },
              //       child: Text(
              //         "Tất cả",
              //         style: GoogleFonts.poppins(
              //           textStyle: const TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              // const SizedBox(height: 8),
              // Danh sách category
              // GetBuilder<HomeController>(
              //   builder: (controller) {
              //     return SizedBox(
              //       height: 50,
              //       child: ListView.builder(
              //         scrollDirection: Axis.horizontal,
              //         itemCount: controller.categories.length,
              //         itemBuilder: (context, index) {
              //           final isSelected =
              //               controller.selectedCategory.value == index;
              //           return InkWell(
              //             onTap: () {
              //               controller.updateCategory(index);
              //               print(
              //                   "Selected Category: ${controller.categories[index]}");
              //             },
              //             child: Container(
              //               padding: const EdgeInsets.symmetric(horizontal: 16),
              //               margin: const EdgeInsets.only(right: 8),
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(16),
              //                 color:
              //                     isSelected ? Colors.blue : Colors.grey[200],
              //               ),
              //               alignment: Alignment.center,
              //               child: Text(
              //                 controller.categories[index],
              //                 style: TextStyle(
              //                   color: isSelected ? Colors.white : Colors.black,
              //                 ),
              //               ),
              //             ),
              //           );
              //         },
              //       ),
              //     );
              //   },
              // ),
              // const SizedBox(height: 16),
              // Carousel Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Các tour mới nhất",
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      print("View all destinations");
                    },
                    child: Text(
                      "",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              // Carousel slider hiển thị các điểm đến phổ biến
              GetBuilder<HomeController>(
                builder: (controller) {
                  if (controller.newTours.isEmpty) {
                    return Center(
                      child: Text('Không có địa điểm phổ biến để hiển thị'),
                    );
                  }
                  return CarouselSlider.builder(
                    itemCount: controller.newTours.length,
                    itemBuilder: (context, index, realIndex) {
                      final destination = controller.newTours[index];
                      return _buildCarouselItem(
                        imageUrl: destination['IMAGES'][0] ??
                            "https://via.placeholder.com/100",
                        title: destination['TOUR_NAME'] ?? "null",
                        location: destination['LOCATION'] ?? "null",
                        price: controller
                            .formatCurrency(destination['PRICE_PER_PERSON']),
                        tourData: destination ?? {},
                      );
                    },
                    options: CarouselOptions(
                      height: 220,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        controller.updateIndex(index);
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              Text(
                "Các tour phổ biến",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),

              // ListView hiển thị các điểm đến từ danh sách
              _buildDestinationList(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Xin chào!!",
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
          ),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.blue),
              const SizedBox(width: 4),
              Obx(
                () => Text(
                  "${controller.user.value?.displayName ?? "Nhím nhỏ"}",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.toNamed('/chat');
            },
            icon: Icon(Icons.message_outlined, color: AppColors.primary)),
        IconButton(
            onPressed: () {
              Get.toNamed('/cart');
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.primary,
            )),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png"), // Thay thế bằng link avatar
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0), // Chiều cao của đường line
        child: Container(
          color: AppColors.grey1, // Màu của đường line
          height: 1.0, // Độ dày của đường line
        ),
      ),
    );
  }

  // Widget cho một phần tử trong carousel
  Widget _buildCarouselItem({
    required String imageUrl,
    required String title,
    required String location,
    required String price,
    required Map<String, dynamic> tourData,
  }) {
    return InkWell(
      onTap: () {
        // Chuyển hướng đến trang chi tiết Tour và truyền thông tin tour
        // print(tourData["CALENDAR_TOUR"]);
        Get.toNamed('/detail-tour', arguments: tourData);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.2),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow
                            .ellipsis, // Cắt ngắn văn bản nếu quá dài
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.white, size: 14),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget hiển thị danh sách các điểm đến
  Widget _buildDestinationList() {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Không scroll riêng
          itemCount: controller.destinations.length,
          itemBuilder: (context, index) {
            final destination = controller.destinations[index];
            return _buildDestinationItem(
              imageUrl:
                  destination['IMAGES'][0] ?? "https://via.placeholder.com/100",
              title: destination['TOUR_NAME'] ?? "null",
              location: destination['LOCATION'] ?? "null",
              description: destination['DESCRIPTION'] ?? "null",
              price: destination['PRICE_PER_PERSON'] ?? "10000",
              tourData: destination ?? {},
            );
          },
        );
      },
    );
  }

  // Widget cho từng mục trong danh sách điểm đến
  Widget _buildDestinationItem({
    required String imageUrl,
    required String title,
    required String location,
    required String price,
    required String description,
    // required int index,
    required Map<String, dynamic> tourData,
  }) {
    return InkWell(
      onTap: () {
        print(tourData);
        Get.toNamed('/detail-tour', arguments: tourData);
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
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl ?? "https://via.placeholder.com/150",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print("Image load error: $error");
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
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "null",
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
                          maxLines: 1,
                          location ?? "null",
                          overflow: TextOverflow
                              .ellipsis, // Cắt ngắn văn bản nếu quá dài
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
                    description ?? "null",
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.formatCurrency(price),
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
