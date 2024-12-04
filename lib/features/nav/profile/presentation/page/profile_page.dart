import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Trang cá nhân',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              controller.logout();
            },
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Sử dụng Stack để đè các thành phần lên ảnh bìa
            Stack(
              alignment:
                  Alignment.center, // Canh giữa cho các thành phần bên trong
              children: [
                // Ảnh bìa với chiều cao cố định
                SizedBox(
                  height:
                      250, // Tăng chiều cao cho ảnh bìa để có thêm không gian
                  width: double
                      .infinity, // Cho phép ảnh bìa lấp đầy theo chiều ngang
                  child: Image.network(
                    "https://res.cloudinary.com/dcuvwf9nx/image/upload/v1730701351/BookingTour/Tours/33d0a824fa331f551e400368ac57f87e_hmtcne.jpg",
                    fit: BoxFit.cover, // Điều chỉnh ảnh cho vừa khít
                  ),
                ),
                // Đặt Avatar, tên và nút chỉnh sửa trong Column nằm trên ảnh bìa
                Positioned(
                  top: Get.height *
                      0.1, // Điều chỉnh vị trí của ảnh đại diện và thông tin
                  child: Column(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.dataUser['PHOTO_URL'] !=
                                  null
                              ? NetworkImage(controller.dataUser['PHOTO_URL'])
                              : const AssetImage(
                                      'assets/images/default_avt.jpg')
                                  as ImageProvider, // Sử dụng ảnh mặc định nếu không có URL
                        ),
                      ),
                      Obx(() {
                        if (controller.dataUser["FULLNAME"] != null) {
                          return Text(
                            "${controller.dataUser['FULLNAME']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          );
                        } else {
                          return const Text("No user info available");
                        }
                      }),
                      TextButton(
                        onPressed: () {
                          controller.pickAndUploadImage();
                        },
                        child: const Text(
                          'Chỉnh sửa',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Các tùy chọn của người dùng
            ListView(
              shrinkWrap: true, // Đảm bảo ListView không chiếm hết không gian
              physics:
                  const NeverScrollableScrollPhysics(), // Tắt cuộn cho ListView
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildProfileOption(
                  icon: Icons.person_outline,
                  label: 'Thông tin cá nhân',
                  onTap: () {
                    Get.toNamed('/personal-info');
                  },
                ),
                // _buildProfileOption(
                //   icon: Icons.favorite_outline,
                //   label: 'Danh sách yêu thích',
                //   onTap: () {
                //     // Điều hướng đến trang danh sách yêu thích
                //   },
                // ),
                _buildProfileOption(
                  icon: Icons.list,
                  label: 'Lịch sử đặt Tour',
                  onTap: () {
                    Get.toNamed('/history-booking');
                  },
                ),
                _buildProfileOption(
                  icon: Icons.lock_outline,
                  label: 'Thay đổi mật khẩu',
                  onTap: () {
                    Get.toNamed('/change-password');
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
