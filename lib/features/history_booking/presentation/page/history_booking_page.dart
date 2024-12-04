import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:reading_app/features/history_booking/presentation/controller/history_booking_controller.dart';

// Function to format date
String formatDate(String dateStr) {
  try {
    final date = DateTime.parse(dateStr);
    return DateFormat('dd/MM/yyyy').format(date);
  } catch (e) {
    return 'Invalid date';
  }
}

String formatCurrency(String price) {
  final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  // Sử dụng `double.tryParse` để chuyển chuỗi thành số, trả về 0 nếu chuyển đổi không thành công
  final doublePrice = double.tryParse(price) ?? 0.0;
  return formatter.format(doublePrice);
}

// Trang Lịch sử Booking
class HistoryBookingPage extends GetView<HistoryBookingController> {
  const HistoryBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Gọi Controller trong context của trang
    final HistoryBookingController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đặt tour'),
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
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.bookingData.length,
            itemBuilder: (context, index) {
              final booking = controller.bookingData[index];
              final bookingId =
                  booking['_id']; // Assuming booking ID is stored in `_id`
              final tour = booking['LIST_TOURS'][0]['TOUR_ID'];
              final tourName =
                  tour != null ? tour['TOUR_NAME'] : 'Unknown Tour';
              final location =
                  booking['LIST_TOURS'][0]["TOUR_ID"]['LOCATION'] ?? 'Unknown';
              final startDate =
                  formatDate(booking['LIST_TOURS'][0]['START_DATE'] ?? '');
              final endDate =
                  formatDate(booking['LIST_TOURS'][0]['END_DATE'] ?? '');
              final slot = booking['LIST_TOURS'][0]['SLOT'].toString();
              final totalPrice =
                  formatCurrency(booking['TOTAL_PRICE'].toString());
              final status = booking['STATUS'] ?? 'Unknown';
              final imageUrl = tour != null
                  ? tour['IMAGES'][0] ?? 'https://via.placeholder.com/150'
                  : 'https://via.placeholder.com/150';

              return GestureDetector(
                onTap: () {
                  print('Booking ID: $bookingId');
                  Get.toNamed('/detail-booking', arguments: bookingId);
                },
                child: BookingCard(
                  imageUrl: imageUrl,
                  tourName: tourName,
                  location: location,
                  startDate: startDate,
                  endDate: endDate,
                  slot: slot,
                  totalPrice: totalPrice,
                  status: status,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Widget card tùy chỉnh cho lịch sử booking
class BookingCard extends StatelessWidget {
  final String imageUrl;
  final String tourName;
  final String location;
  final String startDate;
  final String endDate;
  final String slot;
  final String totalPrice;
  final String status;

  const BookingCard({
    Key? key,
    required this.imageUrl,
    required this.tourName,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.slot,
    required this.totalPrice,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh
            Image.network(
              imageUrl,
              height: 180.0,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey,
                  height: 180.0,
                  child: const Center(
                    child: Text(
                      'Image not available',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên tour
                  Text(
                    tourName,
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  // Địa điểm
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.blueAccent, size: 16),
                      const SizedBox(width: 4.0),
                      Text(
                        location,
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  // Ngày bắt đầu và kết thúc
                  Text(
                    'Ngày đi: $startDate',
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Ngày về: $endDate',
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  // Số lượng slot
                  Text(
                    'Số vé: $slot',
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  // Tổng giá tiền
                  Text(
                    'Tổng tiền: $totalPrice',
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  // Trạng thái
                  Text(
                    'Trạng thái: $status',
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: status == 'SUCCESS'
                          ? Colors.green
                          : status == 'Pending'
                              ? Colors.orange
                              : Colors.red,
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
