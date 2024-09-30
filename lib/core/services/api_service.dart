import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl;
  String? bearerToken; // Biến chứa token

  ApiService(this.baseUrl, [this.bearerToken]) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };

    // Nếu có token thì thêm vào headers
    if (bearerToken != null && bearerToken!.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $bearerToken';
    }

    _dio.options.validateStatus = (status) {
      // Trả về true cho mã trạng thái từ 200 đến 499 để xử lý các mã trạng thái
      // mà bạn muốn xử lý đặc biệt.
      return status! < 500; // Không ném lỗi cho các mã trạng thái nhỏ hơn 500
    };
  }

  // Hàm để cập nhật token nếu cần
  void updateToken(String newToken) {
    bearerToken = newToken;
    _dio.options.headers['Authorization'] = 'Bearer $bearerToken';
  }

  Future<Map<String, dynamic>> postData(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      throw Exception('Failed to post data: ${e.message}');
    }
  }

  Future<List<dynamic>> getData(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      // print('Response status: ${response.statusCode}');
      // print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data is List) {
          return response.data
              as List<dynamic>; // Trả về danh sách dữ liệu nếu đúng kiểu
        } else {
          throw Exception('Unexpected data format');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      throw Exception('Failed to get data: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> putData(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response.data;
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      throw Exception('Failed to put data: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> deleteData(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response.data;
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      throw Exception('Failed to delete data: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> patchData(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch(endpoint, data: data);
      return response.data;
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      throw Exception('Failed to patch data: ${e.message}');
    }
  }
}
