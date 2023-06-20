import 'package:flutter/services.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/saved_address_screen/controller/saved_address_controller.dart';

class SavedAddressesScreen extends GetWidget<SavedAddressesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Saved Addresses",
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
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? SizedBox(
                  height: Get.height,
                  child: Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.blue, size: 50),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () => controller.savedDeliveryAddress.isEmpty
                          ? SizedBox(
                        height: Get.height - 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonImageView(
                                url: noAddressesFound,
                              ),
                              Text(
                                "No Addresses found",
                                style: GoogleFonts.getFont(
                                  'Signika Negative',
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Get.width * 0.05,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                          : ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: Get.width - 75,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 10)
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10.0, 8, 10, 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .savedDeliveryAddress[
                                                        index]!
                                                    .addressType,
                                                style: GoogleFonts.getFont(
                                                  'Signika Negative',
                                                  textStyle: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: Get.width * 0.08,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${controller.savedDeliveryAddress[index]!.addressLine1}, ${controller.savedDeliveryAddress[index]!.addressLine2}, ${controller.savedDeliveryAddress[index]!.city}, ${controller.savedDeliveryAddress[index]!.state}, ${controller.savedDeliveryAddress[index]!.country} - ${controller.savedDeliveryAddress[index]!.postalCode}",
                                                style: GoogleFonts.getFont(
                                                  'Signika Negative',
                                                  textStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: Get.width * 0.06,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "Mobile Number: ${controller.savedDeliveryAddress[index]!.mobile}",
                                                style: GoogleFonts.getFont(
                                                  'Signika Negative',
                                                  textStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: Get.width * 0.04,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              controller.setEditData(index);
                                              openSavedAddressBottomSheet();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.blue.shade400,
                                                        Colors.blue.shade800
                                                      ])),
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: Get.width * 0.05,
                                              ),
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
                                                  titleStyle:
                                                      GoogleFonts.getFont(
                                                    'Signika Negative',
                                                  ),
                                                  content: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Are you sure want to delete?",
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Signika Negative',
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          MaterialButton(
                                                            shape: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                            color: Colors.blue,
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                              "Cancle",
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Signika Negative',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          MaterialButton(
                                                            shape: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                            color: Colors.red,
                                                            onPressed: () {
                                                              HapticFeedback
                                                                  .heavyImpact();
                                                              controller.deleteAddress(
                                                                  controller
                                                                      .savedDeliveryAddress[
                                                                          index]!
                                                                      .id
                                                                      .toString());
                                                            },
                                                            child: Text(
                                                              "delete",
                                                              style: GoogleFonts
                                                                  .getFont(
                                                                'Signika Negative',
                                                                color: Colors
                                                                    .white,
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
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.blue.shade400,
                                                        Colors.blue.shade800
                                                      ])),
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
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 20,
                                  ),
                              itemCount:
                                  controller.savedDeliveryAddress.length),
                    )
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () async {
          await openSavedAddressBottomSheet();
        },
        tooltip: "Add Address",
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

  Future openSavedAddressBottomSheet() {
    return Get.bottomSheet(
      SingleChildScrollView(
        child: Form(
          key: controller.savedAddressFormKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.03),
                _buildTextInputField(
                  "Address Type",
                  controller.addressType,
                  "Please provide Address Type",
                ),
                SizedBox(height: Get.height * 0.03),
                _buildTextInputField(
                  "Address Line 1",
                  controller.addressLine1,
                  "Please provide Address here",
                ),
                SizedBox(height: Get.height * 0.03),
                _buildTextInputField(
                  "Address Line 2",
                  controller.addressLine2,
                  "Please provide Address here",
                ),
                SizedBox(height: Get.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTextInputField(
                      "Country",
                      controller.country,
                      "Please provide country",
                      Get.width / 2.6,
                    ),
                    _buildTextInputField(
                      "State",
                      controller.state,
                      "Please provide State",
                      Get.width / 2.6,
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTextInputField(
                      "City",
                      controller.city,
                      "Please provide City",
                      Get.width / 2.6,
                    ),
                    _buildTextInputField(
                      "Zipcode",
                      controller.zipCode,
                      "Please provide Zip Code",
                      Get.width / 2.6,
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.03),
                _buildTextInputField(
                  "Mobile Number",
                  controller.mobile,
                  "Please provide Mobile Number",
                ),
                SizedBox(height: Get.height * 0.03),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      if (controller.savedAddressFormKey.currentState!
                          .validate()) {
                        await controller.uploadDeliveryAddress();
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
                                  "Add Address",
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
      width: width == 50 ? Get.width : width,
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
}
