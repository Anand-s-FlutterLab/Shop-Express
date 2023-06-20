import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/customer_services_screen/controller/customer_services_controller.dart';

class CustomerSupportScreen extends GetWidget<CustomerSupportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Customer Support",
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
        child: Obx(
          () => controller.isLoading.value
              ? Container(
                  height: Get.height * 0.9,
                  child: Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.blue, size: 50),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: CommonImageView(
                          url: controller.customerSupportModel.imageAddress,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Need help? Our friendly and knowledgeable support agents are ready to assist you. Contact us via phone and email",
                        style: GoogleFonts.getFont(
                          'Signika Negative',
                          color: Colors.grey,
                          fontSize: Get.width * 0.05,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Email",
                        style: GoogleFonts.getFont(
                          'Signika Negative',
                          color: Colors.grey,
                          fontSize: Get.width * 0.04,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            controller.customerSupportModel.email,
                            style: GoogleFonts.getFont(
                              'Signika Negative',
                              color: Colors.blue.shade800,
                              fontSize: Get.width * 0.06,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Mobile Number",
                        style: GoogleFonts.getFont(
                          'Signika Negative',
                          color: Colors.grey,
                          fontSize: Get.width * 0.04,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            controller.customerSupportModel.mobileNumber,
                            style: GoogleFonts.getFont(
                              'Signika Negative',
                              color: Colors.blue.shade800,
                              fontSize: Get.width * 0.06,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
