import 'dart:convert';

class InforModel {
  final String? uid;
  final String? email;
  final String? phoneNumber;
  String? displayName;
  String? photoURL;

  InforModel({
    this.uid,
    this.email,
    this.phoneNumber,
    this.displayName,
    this.photoURL,
  });

  factory InforModel.fromJson(Map<String, dynamic> json) {
    return InforModel(
      uid: json['uid'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      displayName: json['displayName'],
      photoURL: json['photoURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
