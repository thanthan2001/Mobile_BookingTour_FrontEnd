import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/features/nav/explore/presentation/controller/explore_controller.dart';

class ExplorePage extends GetView<ExploreController> {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.textController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm Tour',
                  hintStyle: TextStyle(color: AppColors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon:
                        const Icon(Icons.clear, size: 28, color: Colors.black),
                    onPressed: controller.clearSearch,
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search,
                        size: 28, color: AppColors.primary),
                    onPressed: () {
                      final query = controller.textController.text;
                      controller
                          .onSearch(query); // Gọi hàm onSearch với từ khóa
                    },
                  ),
                ),
                style: const TextStyle(fontSize: 18.0),
                onSubmitted: (value) {
                  controller.onSearch(
                      value); // Gọi hàm onSearch khi nhấn Enter hoặc Check
                },
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Obx(() {
        return controller.searchText.value.isEmpty
            ? Center(child: Text('Vui lòng tìm kiếm Tour'))
            : _buildSearchResults(controller);
      }),
    );
  }

  Widget _buildSearchResults(ExploreController controller) {
    return ListView.builder(
      itemCount: controller.searchResults.length,
      itemBuilder: (context, index) {
        final tour = controller.searchResults[index];
        return _buildTourCard(tour);
      },
    );
  }

  Widget _buildTourCard(Map<String, dynamic> tour) {
    return GestureDetector(
      onTap: () {
        print(tour);
        Get.toNamed('/detail-tour', arguments: tour);
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Image.network(
                  tour['IMAGES'][0],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      'https://via.placeholder.com/150',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tour['TOUR_NAME'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      tour['LOCATION'],
                      style: TextStyle(color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    Text(
                      tour['DESCRIPTION'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${tour['PRICE_PER_PERSON']} VND/Người',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
