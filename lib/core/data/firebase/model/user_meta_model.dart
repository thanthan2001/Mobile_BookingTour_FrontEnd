class UserMetadata {
  final DateTime creationTime;
  final DateTime lastSignInTime;

  UserMetadata({
    required this.creationTime,
    required this.lastSignInTime,
  });

  factory UserMetadata.fromJson(Map<String, dynamic> json) {
    return UserMetadata(
      creationTime: DateTime.parse(json['creationTime']),
      lastSignInTime: DateTime.parse(json['lastSignInTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'creationTime': creationTime.toIso8601String(),
      'lastSignInTime': lastSignInTime.toIso8601String(),
    };
  }
}

class UserInfo {
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final String providerId;
  final String uid;

  UserInfo({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    required this.providerId,
    required this.uid,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
      providerId: json['providerId'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'providerId': providerId,
      'uid': uid,
    };
  }
}

class UserModel {
  final String? displayName;
  final String email;
  final bool isEmailVerified;
  final bool isAnonymous;
  final UserMetadata metadata;
  final String? phoneNumber;
  final String? photoURL;
  final List<UserInfo> providerData;
  final String? refreshToken;
  final String? tenantId;
  final String uid;

  UserModel({
    this.displayName,
    required this.email,
    required this.isEmailVerified,
    required this.isAnonymous,
    required this.metadata,
    this.phoneNumber,
    this.photoURL,
    required this.providerData,
    this.refreshToken,
    this.tenantId,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var providerDataFromJson = json['providerData'] as List;
    List<UserInfo> providerDataList = providerDataFromJson.map((i) => UserInfo.fromJson(i)).toList();

    return UserModel(
      displayName: json['displayName'],
      email: json['email'],
      isEmailVerified: json['isEmailVerified'],
      isAnonymous: json['isAnonymous'],
      metadata: UserMetadata.fromJson(json['metadata']),
      phoneNumber: json['phoneNumber'],
      photoURL: json['photoURL'],
      providerData: providerDataList,
      refreshToken: json['refreshToken'],
      tenantId: json['tenantId'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'isAnonymous': isAnonymous,
      'metadata': metadata.toJson(),
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'providerData': providerData.map((e) => e.toJson()).toList(),
      'refreshToken': refreshToken,
      'tenantId': tenantId,
      'uid': uid,
    };
  }
}
