import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/add_product_screen/controller/add_product_controller.dart';

class AddProductScreen extends GetWidget<AddProductController> {
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
          onTap: () {
            Get.back();
            selectedBottomNavigationIndex = 0;
          },
          child: const Icon(Icons.arrow_back_ios, color: Colors.grey),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Form(
            key: controller.addProductFormKey,
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.02),
                const Divider(),
                Text(
                  "Product Information",
                  style: GoogleFonts.getFont(
                    'Signika Negative',
                    fontSize: Get.width * 0.04,
                  ),
                ),
                const Divider(),
                SizedBox(height: Get.height * 0.01),
                _buildTextInputField(
                  "Product Brand",
                  controller.productBrandController,
                  "Please provide product Brand",
                ),
                SizedBox(height: Get.height * 0.03),
                _buildTextInputField(
                  "Product Name",
                  controller.productNameController,
                  "Please provide product Name",
                ),
                SizedBox(height: Get.height * 0.03),
                _buildTextInputField(
                  "Product Description",
                  controller.productDescriptionController,
                  "Please provide product Description",
                ),
                SizedBox(height: Get.height * 0.03),
                _buildTextInputField(
                  "Product Category",
                  controller.productCategoryController,
                  "Please provide product Category",
                ),
                SizedBox(height: Get.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTextInputField(
                      "Product ID",
                      controller.productIDController,
                      "Please provide product ID",
                      Get.width / 2.6,
                    ),
                    _buildTextInputField(
                      "Product Price",
                      controller.productPriceController,
                      "Please provide product Price",
                      Get.width / 2.6,
                      false,
                      (value) {
                        if (value.isNotEmpty) {
                          controller.productDisplayPriceController.text =
                              controller.getDiscountedPrice().toString();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTextInputField(
                      "Product Discount",
                      controller.productDiscountController,
                      "Please provide product Discount",
                      Get.width / 2.6,
                      false,
                      (value) {
                        if (value.isNotEmpty) {
                          controller.productDisplayPriceController.text =
                              controller.getDiscountedPrice().toString();
                        }
                      },
                    ),
                    _buildTextInputField(
                      "Product Display Price",
                      controller.productDisplayPriceController,
                      "Please provide product Display Price",
                      Get.width / 2.6,
                      true,
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upload Images",
                      style: GoogleFonts.getFont(
                        'Signika Negative',
                        fontSize: Get.width * 0.04,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addProductImageFile();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade800
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(width: Get.width * 0.01),
                              Text(
                                "Add Images",
                                style: GoogleFonts.getFont(
                                  'Signika Negative',
                                  color: Colors.white,
                                  fontSize: Get.width * 0.035,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                SizedBox(height: Get.height * 0.01),
                Obx(
                  () => controller.productImages.isEmpty
                      ? const SizedBox(
                          height: 10,
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 25.0,
                            mainAxisSpacing: 25.0,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: controller.productImages.length,
                          itemBuilder: (context, index) {
                            return _buildImagePicker(index);
                          },
                        ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product Details",
                      style: GoogleFonts.getFont(
                        'Signika Negative',
                        fontSize: Get.width * 0.04,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addTextEditingController();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade800
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              SizedBox(width: Get.width * 0.01),
                              Text(
                                "Add Information",
                                style: GoogleFonts.getFont(
                                  'Signika Negative',
                                  color: Colors.white,
                                  fontSize: Get.width * 0.035,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                SizedBox(height: Get.height * 0.03),
                Obx(
                  () => controller.labelControllers.isEmpty
                      ? SizedBox()
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildTextInputField(
                                    "Label",
                                    controller.labelControllers[index],
                                    "Please provide Label",
                                    Get.width / 2.6,
                                  ),
                                  _buildTextInputField(
                                    "Value",
                                    controller.valueControllers[index],
                                    "Please provide Value",
                                    Get.width / 2.6,
                                  ),
                                ],
                              ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: Get.height * 0.02),
                          itemCount: controller.valueControllers.length),
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      if (controller.addProductFormKey.currentState!
                          .validate()) {
                        await controller.uploadImagesAndAddProductToFirebase();
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
                          child: controller.isAddProductPressed.value
                              ? LoadingAnimationWidget.threeArchedCircle(
                                  color: Colors.white, size: Get.width * 0.1)
                              : Text(
                                  "Add Product",
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

  Widget _buildImagePicker(
    int index,
  ) {
    return SizedBox(
      width: Get.width / 2.6,
      height: Get.height * 0.25,
      child: Obx(
        () => GestureDetector(
          onVerticalDragCancel: () {
            controller.productImages.removeAt(index);
          },
          onTap: () {
            controller.openImagePicker(index);
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
              child: controller.productImages[index].value != null
                  ? Image.file(controller.productImages[index].value!,
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
