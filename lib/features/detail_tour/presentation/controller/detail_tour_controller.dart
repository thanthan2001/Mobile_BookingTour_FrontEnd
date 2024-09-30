import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class DetailTourController extends GetxController {
  late Map<String, dynamic> tourData;
  var isFavorite = false.obs;
  var isExpanded = false.obs; // Khai báo biến isFavorite
  // Khai báo biến tourData
  List<String> images = [];
  var currentImage = "".obs;
  @override
  void onInit() {
    super.onInit();
    tourData = Get.arguments ?? {};
    List<String> images = List<String>.from(tourData['IMAGES'] ?? []);
    currentImage.value = images[0];
    this.images = images;
// Nhận dữ liệu từ Get.arguments
  }

  void toggleDescription() {
    isExpanded.value = !isExpanded.value; // Đổi giữa true và false
  }

  void toggleFavorite() {
    print(isFavorite.value);
    isFavorite.value = !isFavorite.value;
  }

  void changeImage(String newImage) {
    currentImage.value = newImage;
  }

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
}
