import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/email_verification_screen/controller/email_verification_controller.dart';

class EmailVerificationScreen extends GetWidget<EmailVerificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height - 50,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    emailVerificationImage,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Email Verification Sent",
                  style: GoogleFonts.getFont('Signika Negative',
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * 0.1),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Congratulations! We've sent a verification email to your inbox. Please click on the link provided to verify your email address and unlock the full benefits of our e-commerce app. Thank you for joining us on this exciting journey!",
                  style: GoogleFonts.getFont(
                    'Signika Negative',
                    color: Colors.black.withOpacity(0.6),
                    fontSize: Get.width * 0.06
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
