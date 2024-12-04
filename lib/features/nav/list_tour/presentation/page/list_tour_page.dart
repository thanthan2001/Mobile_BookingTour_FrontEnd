import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/features/nav/list_tour/presentation/controller/list_tour_controller.dart';

class ListTourPage extends GetView<ListTourController> {
  const ListTourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    controller.user.value?.displayName ?? "Nhím nhỏ",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
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
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_1280.png",
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.grey1,
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Thêm Row chứa dropdown và tiêu đề
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Danh sách Tour",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Đảm bảo DropdownButtonFormField có kích thước phù hợp
                Expanded(
                  flex: 2,
                  child: Obx(() {
                    return DropdownButtonFormField<String>(
                      value: controller.selectedFilter.value.isEmpty
                          ? "Tất cả"
                          : controller.selectedFilter.value,
                      hint: const Text(
                        "Chọn loại tour",
                        style: TextStyle(color: Colors.grey),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                              color: Colors.grey.shade300, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.5),
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue,
                        size: 24,
                      ),
                      dropdownColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      items: [
                        'Tất cả',
                        'Núi',
                        'Biển',
                        'Thác nước',
                        'Du Thuyền',
                        'Hang động',
                      ].map((String filter) {
                        return DropdownMenuItem<String>(
                          value: filter,
                          child: Text(filter),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.updateFilter(newValue);
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (controller.filteredTours.isEmpty) {
                  return const Center(child: Text('Không có tour nào'));
                }

                return ListView.builder(
                  itemCount: controller.filteredTours.length,
                  itemBuilder: (context, index) {
                    final tour = controller.filteredTours[index];
                    return _buildDestinationItem(
                      imageUrl: tour['IMAGES']?[0] ?? '',
                      title: tour['TOUR_NAME'] ?? '',
                      location: tour['LOCATION'] ?? '',
                      price: tour['PRICE_PER_PERSON'] ?? '',
                      description: tour['DESCRIPTION'] ?? '',
                      tourData: tour,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Định nghĩa widget hiển thị thông tin tour
  Widget _buildDestinationItem({
    required String imageUrl,
    required String title,
    required String location,
    required String price,
    required String description,
    required Map<String, dynamic> tourData,
  }) {
    return InkWell(
      onTap: () {
        Get.toNamed('/detail-tour', arguments: tourData);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                  imageUrl,
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
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
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
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${controller.formatCurrency(price)}',
                    style: const TextStyle(
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
