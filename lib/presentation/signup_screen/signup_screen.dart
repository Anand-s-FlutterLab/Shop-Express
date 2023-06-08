import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/signup_screen/controller/signup_controller.dart';
import 'package:shopexpress/core/Utils/validation_function.dart';
import 'package:shopexpress/routes/app_routes.dart';

class SignupScreen extends GetWidget<SignupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Image(
                  image: AssetImage(signupBackgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
              Form(
                key: controller.signupFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign up now!",
                        style: GoogleFonts.getFont(
                          'Signika Negative',
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * 0.1,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: Get.width - 75,
                        decoration: AppDecoration.inputBoxDecorationShaddow(),
                        child: TextFormField(
                            style: GoogleFonts.getFont('Signika Negative',
                                fontSize: Get.width * 0.05),
                            decoration: AppDecoration().textInputDecoration(
                                "First Name", 'First Name'),
                            focusNode: FocusNode(),
                            controller: controller.firstNameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please provide first name";
                              }
                              return null;
                            }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: Get.width - 75,
                        decoration: AppDecoration.inputBoxDecorationShaddow(),
                        child: TextFormField(
                            style: GoogleFonts.getFont('Signika Negative',
                                fontSize: Get.width * 0.05),
                            decoration: AppDecoration()
                                .textInputDecoration("Last Name", 'Last Name'),
                            focusNode: FocusNode(),
                            controller: controller.lastNameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please provide last name";
                              }
                              return null;
                            }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: Get.width - 75,
                        decoration: AppDecoration.inputBoxDecorationShaddow(),
                        child: TextFormField(
                            style: GoogleFonts.getFont('Signika Negative',
                                fontSize: Get.width * 0.05),
                            keyboardType: TextInputType.emailAddress,
                            decoration: AppDecoration().textInputDecoration(
                                "Email Address", 'Email Address'),
                            focusNode: FocusNode(),
                            controller: controller.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide a Email Address';
                              }
                              if (!emailValidator.hasMatch(value)) {
                                return 'Enter Valid Email';
                              }
                              return null;
                            }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: Get.width - 75,
                        decoration: AppDecoration.inputBoxDecorationShaddow(),
                        child: TextFormField(
                            style: GoogleFonts.getFont('Signika Negative',
                                fontSize: Get.width * 0.05),
                            maxLines: null,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: AppDecoration()
                                .textInputDecoration("Password", 'Password'),
                            focusNode: FocusNode(),
                            controller: controller.passwordController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please provide Password";
                              }
                              if (!passwordValidator.hasMatch(value)) {
                                return 'Enter Valid Password';
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
                          onTap: () {
                            controller.onSignup();
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
                              child: Obx(
                                () => controller.isSignupPressed.value
                                    ? LoadingAnimationWidget.threeArchedCircle(
                                        color: Colors.white,
                                        size: Get.width * 0.1)
                                    : Text(
                                        "Signup",
                                        style: GoogleFonts.getFont(
                                          'Signika Negative',
                                          color: Colors.white,
                                          fontSize: Get.width * 0.06,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => Get.offNamed(
                            AppRoutes.loginScreen,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already Have a Account? ",
                                style: GoogleFonts.getFont('Signika Negative',
                                    fontSize: Get.width * 0.06),
                              ),
                              Text(
                                "Login Here",
                                style: GoogleFonts.getFont('Signika Negative',
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontSize: Get.width * 0.06),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
