import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/ui/widgets/customs/button/button_normal.dart';
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
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Avatar và tên người dùng
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://via.placeholder.com/150'), // Thay bằng ảnh của người dùng
          ),
          const SizedBox(height: 10),
          const Text(
            'Juan Lizcano',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              // Thêm sự kiện thay đổi ảnh
            },
            child: const Text(
              'Chỉnh sửa',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          const SizedBox(height: 20),
          // Các tùy chọn của người dùng
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildProfileOption(
                  icon: Icons.person_outline,
                  label: 'Thông tin cá nhân',
                  onTap: () {
                    Get.toNamed('/personal-info');
                    print("Información personal");
                    // Điều hướng đến trang thông tin cá nhân
                  },
                ),
                _buildProfileOption(
                  icon: Icons.favorite_outline,
                  label: 'Danh sách yêu thích',
                  onTap: () {
                    // Điều hướng đến trang danh sách thú cưng
                  },
                ),
                _buildProfileOption(
                  icon: Icons.list,
                  label: 'Lịch sử đặt Tour',
                  onTap: () {
                    // Điều hướng đến trang danh sách thú cưng
                  },
                ),
                _buildProfileOption(
                  icon: Icons.lock_outline,
                  label: 'Thay đổi mật khẩu',
                  onTap: () {
                    // Điều hướng đến trang đổi mật khẩu
                  },
                ),
                const SizedBox(height: 20),
                // Nút đăng xuất
                ButtonNormal(
                  textChild: "Đăng xuất",
                  onTap: controller.logout,
                ),
              ],
            ),
          ),
        ],
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
