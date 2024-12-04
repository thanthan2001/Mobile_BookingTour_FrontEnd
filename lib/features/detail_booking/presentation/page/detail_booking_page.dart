import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/detail_booking/presentation/controller/detail_booking_controller.dart';

class DetailBookingPage extends GetView<DetailBookingController> {
  const DetailBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đặt tour'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () {
          if (controller.dataBooking.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final bookingData = controller.dataBooking;
          final listTours = bookingData['LIST_TOURS'] as List<dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Customer Info Section
                Text(
                  'Thông tin khách hàng',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tên: ${bookingData['CUSTOMER_NAME'] ?? 'N/A'}'),
                        Text(
                            'Số điện thoại: ${bookingData['CUSTOMER_PHONE'] ?? 'N/A'}'),
                        Text('CMND: ${bookingData['CITIZEN_ID'] ?? 'N/A'}'),
                      ],
                    ),
                  ),
                ),

                // Tour Details Section
                Text(
                  'Chi tiết Tour',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...listTours.map((tour) {
                  final tourInfo = tour['TOUR_ID'];
                  final tourImage = tourInfo['IMAGES'] != null &&
                          tourInfo['IMAGES'].isNotEmpty
                      ? tourInfo['IMAGES'][0]
                      : null;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (tourImage != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                            child: Image.network(
                              tourImage,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tên Tour: ${tourInfo['TOUR_NAME'] ?? 'N/A'}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Ngày đi: ${controller.formatDate(tour['START_DATE']?.substring(0, 10))}',
                              ),
                              Text(
                                'Ngày về: ${controller.formatDate(tour['END_DATE']?.substring(0, 10))}',
                              ),
                              Text(
                                  'Giờ khởi hành: ${tour['START_TIME'] ?? 'N/A'}'),
                              Text('Số chỗ: ${tour['SLOT'] ?? 'N/A'}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                // Booking Info Section
                const SizedBox(height: 16),
                Text(
                  'Thông tin đặt tour',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mã đơn: ${bookingData['_id'] ?? 'N/A'}'),
                        Text(
                            'Tổng giá: ${controller.formatCurrency(bookingData['TOTAL_PRICE'].toString())}'),
                        Text('Trạng thái: ${bookingData['STATUS'] ?? 'N/A'}'),
                        Text(
                            'Loại đặt: ${bookingData['BOOKING_TYPE'] ?? 'N/A'}'),
                        Text(
                          'Ngày tạo: ${bookingData['CREATE_AT']?.substring(0, 10) ?? 'N/A'}',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
