import 'dart:convert';

class AuthenticationModel {
  final String metadata;
  final String idUser;
  final bool success;

  AuthenticationModel({
    required this.metadata,
    required this.idUser,
    required this.success,
  });

  // Tạo một đối tượng AuthenticationModel từ một JSON Map
  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      metadata: json['metadata'] as String,
      idUser: json['idUser'] as String,
      success: json['success'] as bool,
    );
  }

  // Chuyển đổi AuthenticationModel thành JSON Map
  Map<String, dynamic> toJson() {
    return {
      'metadata': metadata,
      'idUser': idUser,
      'success': success,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
