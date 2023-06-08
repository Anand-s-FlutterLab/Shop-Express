import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/forgot_password_screen/controller/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}