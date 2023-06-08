import 'package:flutter/services.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/forgot_password_screen/controller/forgot_password_controller.dart';
import 'package:shopexpress/routes/app_routes.dart';
import 'package:shopexpress/core/Utils/validation_function.dart';
import 'package:shopexpress/theme/app_decoration.dart';

class ForgotPasswordScreen extends GetWidget<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Forgot Password",
          style: GoogleFonts.getFont(
            'Signika Negative',
            textStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue,fontSize: Get.width * 0.05,),
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Form(
            key: controller.forgotPasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.07,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Image(
                      fit: BoxFit.scaleDown,
                      image: AssetImage(forgotPasswordImage),
                    ),
                  ),
                ),
                Text(
                  "Forgot Password?",
                  style: GoogleFonts.getFont('Signika Negative',
                      fontSize: Get.width * 0.09, color: Colors.blue),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Don't worry! It happens. Please enter the email address associated with you account.",
                  style: GoogleFonts.getFont('Signika Negative',
                      color: Colors.black.withOpacity(0.6),
                      fontSize: Get.width * 0.06),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: Get.width,
                  decoration: AppDecoration.inputBoxDecorationShaddow(),
                  child: TextFormField(
                      style: GoogleFonts.getFont(
                        'Signika Negative',
                      ),
                      decoration: AppDecoration().textInputDecoration(
                          "Email Address", 'Email Address'),
                      focusNode: FocusNode(),
                      controller: controller.forgotPasswordController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please provide email";
                        }
                        if (!emailValidator.hasMatch(value)) {
                          return 'Enter Valid Email';
                        }
                        return null;
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                      onTap: () async {
                        await controller.forgotPasswordLinkGenerator();
                        if (controller.isLinkGenerated.value) {
                          Get.defaultDialog(
                              title: "Reset link sent successfully",
                              titleStyle: GoogleFonts.getFont(
                                'Signika Negative',
                              ),
                              content: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "A password reset link has been successfully sent to the email address associated with ${controller.forgotPasswordController.text}. Please check your inbox and follow the instructions in the link to reset your password. Once you have reset your password, you can log in again.",
                                      style: GoogleFonts.getFont(
                                        'Signika Negative',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: MaterialButton(
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide.none),
                                      color: Colors.blue,
                                      onPressed: () {
                                        Get.offNamed(AppRoutes.loginScreen);
                                      },
                                      child: Text(
                                        "Okay",
                                        style: GoogleFonts.getFont(
                                          'Signika Negative',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: Get.width * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade400,
                                Colors.blue.shade800
                              ],
                            )),
                        child: Center(
                          child: Text(
                            "Reset Password",
                            style: GoogleFonts.getFont(
                              'Signika Negative',
                              color: Colors.white,
                              fontSize: Get.width * 0.06,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
