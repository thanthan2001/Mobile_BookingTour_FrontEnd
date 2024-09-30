  class UserModel {
    String? uid;
    String? displayName;
    String? phoneNumber;
    String? photoURL;
    String email;
    String password;
    String creationTime;

    UserModel({
      this.uid,
      this.displayName,
      this.phoneNumber,
      this.photoURL,
      required this.email,
      required this.password,
      required this.creationTime
      
    });

    // Phương thức chuyển đổi từ JSON thành UserModel
    factory UserModel.fromJson(Map<String, dynamic> json) {
      return UserModel(
        uid: json['uid'],
        displayName: json['displayName'],
        phoneNumber: json['phoneNumber'],
        photoURL: json['photoURL'],
        email: json['email'],
        password: json['password'],
        creationTime: json['creationTime'],
      );
    }

    // Phương thức chuyển đổi từ UserModel thành JSON
    Map<String, dynamic> toJson() {
      return {
        'uid': uid,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'photoURL': photoURL,
        'email': email,
        'password': password,
        'creationTime': creationTime,
      };
    }
  }
