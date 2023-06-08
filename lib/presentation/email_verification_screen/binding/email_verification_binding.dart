import 'package:get/get.dart';
import 'package:shopexpress/presentation/email_verification_screen/controller/email_verification_controller.dart';

class EmailVerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EmailVerificationController());
  }

}