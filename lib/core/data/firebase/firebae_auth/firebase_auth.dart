import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reading_app/core/data/firebase/model/result.dart';
import 'package:reading_app/core/data/firebase/model/user_model.dart';

class FirebaseAuthentication {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static Future<Result<UserModel>> signUp(
      {required String email,
      required String password,
      String displayName = ""}) async {
    try {
      // Tạo người dùng mới
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Gửi email xác thực
      await firebaseAuth.currentUser!.sendEmailVerification();
      // Tạo UserModel từ thông tin người dùng
      UserModel newUser = UserModel(
          uid: credential.user?.uid,
          email: email,
          password: password,
          displayName: displayName, // Cần thêm nếu có dữ liệu username
          creationTime:
              DateTime.now().toString(), // Cần thêm nếu có dữ liệu phoneNumber
          phoneNumber: '',
          photoURL: "");

      return Result.success(newUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // Xử lý trường hợp email đã được sử dụng
        return Result.error(FirebaseAuthException(
            code: 'email-already-in-use', message: 'Email đã được sử dụng'));
      }
      return Result.error(e);
    }
  }

  static Future<Result<User>> logIn(
      {required String email, required String password}) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Result.success(credential.user);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<User?>> sendMailVerify() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return Result.success(user);
      } else {
        return Result.error(FirebaseAuthException(
            code: "email_verified", message: "Email is verified"));
      }
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<void> signOut() async => await firebaseAuth.signOut();

  static Future<Result<UserModel>> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Đăng xuất tài khoản Google hiện tại để buộc chọn tài khoản mới
      await googleSignIn.signOut();

      // Nếu bạn muốn người dùng chọn tài khoản, hãy thử cài đặt `forceLogin` thành true
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return Result.error(FirebaseAuthException(
            code: "ERROR_ABORTED_BY_USER", message: "Sign in aborted by user"));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user == null) {
        return Result.error(FirebaseAuthException(
            code: "ERROR_USER_NOT_FOUND",
            message: "User not found after Google sign-in"));
      }

      // Tạo UserModel từ thông tin người dùng
      UserModel googleUserModel = UserModel(
        uid: user.uid,
        email: user.email ?? '', // Đảm bảo email không null
        password: '', // Không có thông tin password từ Google
        displayName: user.displayName, // Cần thêm nếu có dữ liệu username
        phoneNumber: user.phoneNumber,
        photoURL: user.photoURL,
        creationTime: user.metadata.creationTime
            .toString(), // Cần thêm nếu có dữ liệu phoneNumber
      );

      return Result.success(googleUserModel);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(
          FirebaseAuthException(code: "ERROR_UNKNOWN", message: e.toString()));
    }
  }
    // Thêm phương thức xóa tài khoản người dùng dựa trên ID
  static Future<Result<void>> deleteUserAccount(String uid) async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null && user.uid == uid) {
        await user.delete();
        return Result.success(null);
      } else {
        return Result.error(FirebaseAuthException(
          code: 'no-current-user',
          message: 'No user is currently signed in with the provided UID.',
        ));
      }
    } on FirebaseAuthException catch (e) {
      // Xử lý trường hợp yêu cầu xác thực lại trước khi xóa tài khoản
      if (e.code == 'requires-recent-login') {
        return Result.error(FirebaseAuthException(
          code: 'requires-recent-login',
          message: 'Please reauthenticate and try again.',
        ));
      }
      return Result.error(e);
    }
  }
  static fetchSignInMethodsForEmail(String email) {}
}
