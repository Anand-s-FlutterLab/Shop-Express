import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/manage_item_slider_screen/controller/manage_item_slider_controller.dart';
import 'package:shopexpress/widgets/common_image_view.dart';

class ManageItemSliderScreen extends GetWidget<ManageItemSliderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Manage Item Slider",
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
        : Obx(
            () => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: Get.width * 0.03,),
                  ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.itemSliders.length,
                    itemBuilder: (context, index) => buildCardWithOption(index),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: Get.width * 0.03,
                      );
                    },
                  ),
                  SizedBox(height: Get.width * 0.03,),
                ],
              ),
            ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () async {
          await openBottomSheet();
        },
        tooltip: "Add Item Slider",
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade800])),
          child: Icon(Icons.add_rounded, size: Get.width * 0.08),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Product Name"),
                        Text(controller.itemSliders[index].productName),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Product ID"),
                        Text(controller.itemSliders[index].productId),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration:
                          AppDecoration.inputBoxDecorationShadowWithBorder(),
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          width: Get.height * 0.2,
                          height: Get.height * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: CommonImageView(
                            url: controller.itemSliders[index].productImage,
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
            Container(
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
          ],
        ),
      ],
    );
  }

  Future<void> openBottomSheet() async {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Form(
          key: controller.addItemSliderFormKey,
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.03),
              _buildTextInputField(
                "Product Name",
                controller.productNameController,
                "Please provide Product Name",
              ),
              SizedBox(height: Get.height * 0.03),
              _buildTextInputField(
                "Product ID",
                controller.productIDController,
                "Please provide Product ID",
              ),
              SizedBox(height: Get.height * 0.03),
              _buildImagePicker(),
              SizedBox(height: Get.height * 0.03),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    if (controller.addItemSliderFormKey.currentState!
                        .validate()) {
                      await controller.uploadImagesAndAddItemSliderToFirebase();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: Get.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade800],
                      ),
                    ),
                    child: Obx(
                      () => Center(
                        child: controller.isUploadPressed.value
                            ? LoadingAnimationWidget.threeArchedCircle(
                                color: Colors.white, size: Get.width * 0.1)
                            : Text(
                                "Upload Item Slider",
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
              SizedBox(height: Get.height * 0.03),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  Widget _buildTextInputField(
      String labelText, TextEditingController controller, String errorMessage,
      [double width = 50,
      bool readOnly = false,
      void Function(String)? onChanged]) {
    return Container(
      width: width == 50 ? Get.width - 75 : width,
      decoration: AppDecoration.inputBoxDecorationShaddow(),
      child: TextFormField(
        onChanged: onChanged,
        readOnly: readOnly,
        style: GoogleFonts.getFont(
          'Signika Negative',
          fontSize: Get.width * 0.05,
        ),
        keyboardType: TextInputType.text,
        decoration: AppDecoration().textInputDecoration(labelText, labelText),
        controller: controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return errorMessage;
          }
          return null;
        },
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
              child: controller.productImage.value != null
                  ? Image.file(controller.productImage.value!,
                      fit: BoxFit.cover)
                  : Center(
                      child: Text(
                        'Tap to select image',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Signika Negative',
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
