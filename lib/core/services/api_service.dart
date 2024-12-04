import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

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

  // Hàm postParam với query parameters
  Future<Map<String, dynamic>> postParam(
      String endpoint, Map<String, dynamic> params) async {
    try {
      final uri =
          Uri.parse(baseUrl + endpoint).replace(queryParameters: params);
      final response = await _dio.postUri(uri);
      return response.data;
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      throw Exception('Failed to post data with params: ${e.message}');
    }
  }

  Future<List<dynamic>> getData(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);

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

  Future<Map<String, dynamic>> getDataJSON(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          // Trả về đối tượng Map nếu dữ liệu là một JSON object
          return response.data as Map<String, dynamic>;
        } else {
          throw Exception('Unexpected data format: Expected a JSON object');
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

  // Hàm getDataFromUrl để gọi API từ URL đầy đủ
  Future<Map<String, dynamic>> getDataFromUrl(String fullUrl) async {
    try {
      final response = await _dio.get(fullUrl);

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return response.data as Map<String, dynamic>;
        } else {
          throw Exception('Unexpected data format: Expected a JSON object');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      throw Exception('Failed to get data from URL: ${e.message}');
    }
  }

  // Hàm upload ảnh với token
  Future<Map<String, dynamic>> uploadPhoto(File imageFile, String token) async {
    try {
      String endpoint = "/users/photo";

      FormData formData = FormData.fromMap({
        "PHOTO": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'data': response.data};
      } else {
        return {'success': false, 'error': response.statusMessage};
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      return {'success': false, 'error': e.message};
    }
  }
}
