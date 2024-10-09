import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/button/elevated_button_widget.dart';
import 'package:reading_app/features/personal_info/presentation/controller/personal_info_controller.dart'; // Thay đổi theo đường dẫn file của bạn

class PersonalInfoPage extends GetView<PersonalInfoController> {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Get.back(); // Điều hướng về trang trước đó
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildTextField(
              'Họ và Tên',
              'Nhập Họ và Tên',
              controller.fullName,
              required: true,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'Email',
              'exampleEmail@gmail.com',
              controller.email,
              required: true,
            ),
            const SizedBox(height: 10),
            _buildPhoneField(
                'Số điện thoại', 'Nhập số điện thoại', controller.phoneNumber),
            const SizedBox(height: 10),
            // _buildTextField(
            //   'Fecha de nacimiento',
            //   'AAAA/MM/DD',
            //   controller.birthDate,
            //   required: true,
            //   icon: Icons.calendar_today_outlined,
            // ),
            const SizedBox(height: 10),
            // _buildDropdownField(
            //   'Departamento',
            //   controller.department,
            //   ['Select', 'Dept 1', 'Dept 2'], // Thay thế bằng dữ liệu thực tế
            // ),
            const SizedBox(height: 10),
            _buildDropdownField(
              'Thành phố',
              controller.city,
              ['Select', 'City 1', 'City 2'], // Thay thế bằng dữ liệu thực tế
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'Địa chỉ cụ thể',
              'Nhập mô tả địa chỉ cụ thể',
              controller.address,
              required: true,
            ),
            const SizedBox(height: 20),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // Widget TextField
  Widget _buildTextField(String label, String hint, RxString text,
      {bool required = false, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ${required ? '*' : ''}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextField(
          onChanged: (value) => text.value = value,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: icon != null ? Icon(icon) : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  // Widget DropdownField
  Widget _buildDropdownField(
      String label, RxString selectedValue, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Obx(() => DropdownButtonFormField<String>(
              value: selectedValue.value == '' ? null : selectedValue.value,
              onChanged: (newValue) {
                selectedValue.value = newValue ?? '';
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            )),
      ],
    );
  }

  // Widget Phone Field
  Widget _buildPhoneField(String label, String hint, RxString phoneNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                '🇻🇳', // Flag placeholder
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: (value) => phoneNumber.value = value,
                decoration: InputDecoration(
                  hintText: hint,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget Nút Lưu thông tin
  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButtonWidget(
        ontap: () {},
        icon: '',
        text: 'OK',
      ),
    );
  }
}
