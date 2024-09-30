class UserModel {
  final String uid;
  final String email;
  final String? password;
  String? displayName;
  String? photoUrl;
  String? createdAt;

  UserModel({
    required this.uid,
    required this.email,
    this.password,
    this.displayName,
    this.photoUrl,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      password: json['password'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
    };
  }
}
