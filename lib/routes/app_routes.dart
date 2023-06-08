import 'package:get/get.dart';
import 'package:shopexpress/presentation/email_verification_screen/binding/email_verification_binding.dart';
import 'package:shopexpress/presentation/email_verification_screen/email_verification_screen.dart';
import 'package:shopexpress/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:shopexpress/presentation/home_screen/binding/home_binding.dart';
import 'package:shopexpress/presentation/home_screen/home_screen.dart';
import 'package:shopexpress/presentation/login_screen/binding/login_binding.dart';
import 'package:shopexpress/presentation/login_screen/login_screen.dart';
import 'package:shopexpress/presentation/product_details_screen/binding/product_details_binding.dart';
import 'package:shopexpress/presentation/product_details_screen/product_details_screen.dart';
import 'package:shopexpress/presentation/search_product_screen/binding/search_product_binding.dart';
import 'package:shopexpress/presentation/search_product_screen/search_product_screen.dart';
import 'package:shopexpress/presentation/signup_screen/binding/signup_binding.dart';
import 'package:shopexpress/presentation/signup_screen/signup_screen.dart';
import 'package:shopexpress/presentation/forgot_password_screen/binding/forgot_password_binding.dart';
import 'package:shopexpress/presentation/add_product_screen/add_product_screen.dart';
import 'package:shopexpress/presentation/add_product_screen/binding/add_product_binding.dart';
import 'package:shopexpress/presentation/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash_screen";
  static String signupScreen = "/signup_screen";
  static String emailVerificationScreen = "/email_verification_screen";
  static String loginScreen = "/login_screen";
  static String forgotPasswordScreen = "/forgot_password_screen";
  static String homeScreen = "/home_screen";
  static String addProductScreen = "/add_product_screen";
  static String productDetailScreen = "/product_detail_screen";
  static String searchProductScreen = "/search_product_screen";

  static List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      bindings: const [],
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      bindings: [ForgotPasswordBinding()],
    ),
    GetPage(
      name: signupScreen,
      page: () => SignupScreen(),
      bindings: [SignupBinding()],
    ),
    GetPage(
      name: emailVerificationScreen,
      page: () => EmailVerificationScreen(),
      bindings: [EmailVerificationBinding()],
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      bindings: [HomeScreenBinding()],
    ),
    GetPage(
      name: productDetailScreen,
      page: () => ProductDetailsScreen(),
      bindings: [ProductDetailsBinding()],
    ),
    GetPage(
      name: addProductScreen,
      page: () => AddProductScreen(),
      bindings: [AddProductBinding()],
    ),
    GetPage(
      name: searchProductScreen,
      page: () => SearchProductScreen(),
      bindings: [SearchProductBinding()],
    ),
  ];
}