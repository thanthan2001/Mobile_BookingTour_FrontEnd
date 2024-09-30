import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:reading_app/core/data/firebase/model/result.dart';

class FirebaseStorageData {
  static final _storage = FirebaseStorage.instance;

  static Future<Result<String>> uploadImage({
    required File imageFile,
    required String userId,
    required String collection,
  }) async {
    try {
      String imageName = DateTime.now()
          .millisecondsSinceEpoch
          .toString(); // Tạo một tên duy nhất cho hình ảnh
      final ref = _storage
          .ref()
          .child(collection)
          .child(userId)
          .child('$imageName.jpg');
      await ref.putFile(imageFile);
      // Lấy URL của hình ảnh đã tải lên
      String imageUrl = await ref.getDownloadURL();
      return Result.success(imageUrl); // Trả về URL của hình ảnh
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }
}
