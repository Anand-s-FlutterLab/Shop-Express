import 'package:shopexpress/presentation/edit_profile_screen/controller/edit_profile_controller.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/core/Utils/validation_function.dart';

class EditProfileScreen extends GetWidget<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.getFont(
            'Signika Negative',
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: Get.width * 0.05,
            ),
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.grey),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Obx(
            () => controller.isLoading.value
                ? Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.blue, size: 50),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: Form(
                      key: controller.editProfileFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              _buildImagePicker(),
                              Positioned(
                                top: -10,
                                right: -10,
                                child: GestureDetector(
                                  onTap: () => controller.openImagePicker(),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.15),
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(Icons.edit_rounded,
                                          color: Colors.blue.shade800),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: Get.width - 75,
                            decoration:
                                AppDecoration.inputBoxDecorationShaddow(),
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
                            height: 30,
                          ),
                          Container(
                            width: Get.width - 75,
                            decoration:
                                AppDecoration.inputBoxDecorationShaddow(),
                            child: TextFormField(
                                style: GoogleFonts.getFont('Signika Negative',
                                    fontSize: Get.width * 0.05),
                                decoration: AppDecoration().textInputDecoration(
                                    "Last Name", 'Last Name'),
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
                            height: 30,
                          ),
                          Container(
                            width: Get.width - 75,
                            decoration:
                                AppDecoration.inputBoxDecorationShaddow(),
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
                            height: 30,
                          ),
                          Container(
                            width: Get.width - 75,
                            decoration:
                                AppDecoration.inputBoxDecorationShaddow(),
                            child: TextFormField(
                                style: GoogleFonts.getFont('Signika Negative',
                                    fontSize: Get.width * 0.05),
                                keyboardType: TextInputType.number,
                                decoration: AppDecoration().textInputDecoration(
                                    "Mobile Number", 'Mobile Number'),
                                focusNode: FocusNode(),
                                controller: controller.mobileNumberController,
                                validator: (value) {
                                  if (value!.length != 10) {
                                    return 'Enter Valid Mobile Number';
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
                                if (controller.editProfileFormKey.currentState!
                                    .validate()) {
                                  controller.updateProfile();
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
                                  child: Obx(
                                    () => controller.isUpdatePressed.value
                                        ? LoadingAnimationWidget
                                            .threeArchedCircle(
                                                color: Colors.white,
                                                size: Get.width * 0.1)
                                        : Text(
                                            "Update",
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
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return SizedBox(
      width: Get.width / 2.6,
      height: Get.height * 0.25,
      child: Obx(
        () => GestureDetector(
          onTap: () {
            controller.openImagePicker();
          },
          child: Container(
            decoration: AppDecoration.inputBoxDecorationShadowWithBorder(),
            child: Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              width: Get.height * 0.2,
              height: Get.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: controller.profileImage.value != null
                  ? Image.file(controller.profileImage.value!,
                      fit: BoxFit.cover)
                  : CommonImageView(
                      url: controller.editProfileModel.profileUrl.isEmpty
                          ? defaultProfileImage
                          : controller.editProfileModel.profileUrl,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
