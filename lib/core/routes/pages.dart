import 'package:get/get.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/auth/forgot_password/di/forgot_password_binding.dart';
import 'package:reading_app/features/auth/forgot_password/presentation/page/forgot_password_page.dart';
import 'package:reading_app/features/auth/login/di/login_binding.dart';
import 'package:reading_app/features/auth/login/presentation/page/login_page.dart';
import 'package:reading_app/features/auth/register/di/register_binding.dart';
import 'package:reading_app/features/auth/register/presentation/page/register_page.dart';
import 'package:reading_app/features/auth/verifiction/di/verification_binding.dart';
import 'package:reading_app/features/auth/verifiction/presentation/page/verification_page.dart';
import 'package:reading_app/features/auth/verify_otp/di/verify_otp_binding.dart';
import 'package:reading_app/features/auth/verify_otp/presentation/page/verify_page.dart';
import 'package:reading_app/features/cart/di/cart_binding.dart';
import 'package:reading_app/features/cart/presentation/page/cart_page.dart';
import 'package:reading_app/features/detail_tour/di/detail_tour_binding.dart';
import 'package:reading_app/features/detail_tour/presentation/page/detail_tour_page.dart';
import 'package:reading_app/features/infor_payment/di/infor_payment_binding.dart';
import 'package:reading_app/features/infor_payment/presentation/page/infor_payment_page.dart';
import 'package:reading_app/features/main/di/main_binding.dart';
import 'package:reading_app/features/main/presentation/page/main_page.dart';
import 'package:reading_app/features/nav/profile/di/profile_binding.dart';
import 'package:reading_app/features/nav/profile/presentation/page/profile_page.dart';
import 'package:reading_app/features/personal_info/di/personal_info_binding.dart';
import 'package:reading_app/features/personal_info/presentation/page/personal_info_page.dart';
import 'package:reading_app/features/splash/di/splash_binding.dart';
import 'package:reading_app/features/splash/presentation/pages/splash_page.dart';
import 'package:reading_app/features/status_payment/di/status_payment_binding.dart';
import 'package:reading_app/features/status_payment/presentation/page/status_payment_page.dart';
import 'package:reading_app/features/vnpay_payment/di/vnpay_binding.dart';
import 'package:reading_app/features/vnpay_payment/presentation/page/vnpay_page.dart';

class Pages {
  static const initial = Routes.splash;
  static const main = Routes.main;
  static final routes = [
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      binding: MainBindding(),
    ),
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBindding(),
    ),
    // GetPage(
    //     name: Routes.profile,
    //     page: () => ProfilePage(),
    //     binding: ProfileBinding()),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: RegisterBindding(),
    ),
    GetPage(
      name: Routes.verifyOTP,
      page: () => VerifyPage(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.detailTour,
      page: () => DetailTourPage(),
      binding: DetailTourBinding(),
    ),
    GetPage(
      name: Routes.cart,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.personalInfor,
      page: () => PersonalInfoPage(),
      binding: PersonalInfoBinding(),
    ),
    GetPage(
      name: Routes.paymentVNPay,
      page: () => VNPayPage(),
      binding: VNPayBinding(),
    ),
    GetPage(
      name: Routes.statusPayment,
      page: () => StatusPaymentPage(),
      binding: StatusPaymentBinding(),
    ),
    GetPage(
      name: Routes.inforPayment,
      page: () => InforPaymentPage(),
      binding: InforPaymentBinding(),
    ),
  ];
}
