import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reading_app/core/data/firebase/model/result.dart';
import 'package:reading_app/core/data/firebase/model/user_model.dart';

class FirestoreUser {
  static final _fireStoreUserCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<Result<bool>> createUser(UserModel newUserInfo) async {
    try {
      await _fireStoreUserCollection
          .doc(newUserInfo.uid)
          .set(newUserInfo.toJson());
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<UserModel>> getUser(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _fireStoreUserCollection.doc(uid).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> userData =
            (documentSnapshot.data() as Map<String, dynamic>);
        return Result.success(UserModel.fromJson(userData));
      } else {
        return Result.error(FirebaseAuthException(
            code: 'user-not-found',
            message: 'No user found with the provided UID.'));
      }
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<bool>> updateUser(UserModel updatedUserInfo) async {
    try {
      await _fireStoreUserCollection
          .doc(updatedUserInfo.uid)
          .update(updatedUserInfo.toJson());
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }
}
