import 'package:flutter/services.dart';
import 'package:shopexpress/presentation/manage_product_screen/controller/manage_product_controller.dart';
import 'package:shopexpress/core/app_export.dart';

import '../../widgets/common_image_view.dart';

class ManageProductScreen extends GetWidget<ManageProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Product Management",
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
      body: Obx(
        () => controller.isInitialLoading.value
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.blue, size: 50),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.width * 0.03,
                    ),
                    ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                globalProductID.value =
                                    controller.manageProduct[index].productId;
                                Get.toNamed(AppRoutes.productDetailScreen);
                              },
                              child: buildCardWithOption(index),
                            ),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: Get.width * 0.03,
                          );
                        },
                        itemCount: controller.manageProduct.length),
                    SizedBox(
                      height: Get.width * 0.03,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildCardWithOption(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: Get.width - 75,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product Name",
                            style: GoogleFonts.getFont(
                              'Signika Negative',
                              fontSize: Get.width * 0.05,
                            ),
                          ),
                          Text(
                            controller.manageProduct[index].productName,
                            style: GoogleFonts.getFont(
                              'Signika Negative',
                              fontSize: Get.width * 0.05,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Product ID",
                            style: GoogleFonts.getFont(
                              'Signika Negative',
                              fontSize: Get.width * 0.05,
                            ),
                          ),
                          Text(
                            controller.manageProduct[index].productId,
                            style: GoogleFonts.getFont(
                              'Signika Negative',
                              fontSize: Get.width * 0.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration:
                          AppDecoration.inputBoxDecorationShadowWithBorder(),
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: CommonImageView(
                            url: controller
                                .manageProduct[index].displayImageLink,
                            fit: BoxFit.contain,
                            height: 130,
                            width: 130,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade800])),
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: Get.width * 0.05,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                HapticFeedback.heavyImpact();
                Get.defaultDialog(
                    title: "Alert",
                    titleStyle: GoogleFonts.getFont(
                      'Signika Negative',
                    ),
                    content: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Are you sure want to delete?",
                            style: GoogleFonts.getFont(
                              'Signika Negative',
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MaterialButton(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              color: Colors.blue,
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                "Cancle",
                                style: GoogleFonts.getFont(
                                  'Signika Negative',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            MaterialButton(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              color: Colors.red,
                              onPressed: () async {
                                HapticFeedback.heavyImpact();
                                await controller
                                    .deleteProductFromFireStore(index);
                                await controller
                                    .deleteFolderFromCloudStorage(index);
                              },
                              child: Text(
                                "delete",
                                style: GoogleFonts.getFont(
                                  'Signika Negative',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade800])),
                padding: const EdgeInsets.all(5),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: Get.width * 0.05,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
