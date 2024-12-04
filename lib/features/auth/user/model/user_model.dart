class UserModel {
  final String uid;
  final String email;
  final String? phoneNumber;
  String? displayName;

  UserModel({
    required this.uid,
    required this.email,
    this.phoneNumber,
    this.displayName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      displayName: json['displayName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
    };
  }
}
