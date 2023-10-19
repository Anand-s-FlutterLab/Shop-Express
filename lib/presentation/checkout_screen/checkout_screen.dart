import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/checkout_screen/controller/checkout_controller.dart';

class CheckoutScreen extends GetWidget<CheckoutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Checkout",
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
              ? SizedBox(
                  height: Get.height - 120,
                  child: Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.blue, size: 50),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Column(
                    children: [
                      const Divider(),
                      Text(
                        "Select Delivery Address",
                        style: GoogleFonts.getFont(
                          'Signika Negative',
                          fontSize: Get.width * 0.04,
                        ),
                      ),
                      const Divider(),
                      SizedBox(height: Get.height * 0.01),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height * 0.29,
                        child: Obx(
                          () => ListView.separated(
                            itemBuilder: (context, index) => Obx(
                              () => GestureDetector(
                                onTap: () => controller
                                    .selectedAddressIndex.value = index,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: controller
                                                  .selectedAddressIndex.value ==
                                              index
                                          ? Border.all(
                                              color: Colors.blue.shade800)
                                          : null,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10)
                                      ]),
                                  width: Get.width * 0.4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              controller
                                                  .savedAddressesController
                                                  .savedDeliveryAddress[index]!
                                                  .addressType,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.getFont(
                                                'Signika Negative',
                                                textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue,
                                                  fontSize: Get.width * 0.05,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Radio(
                                              value: index,
                                              groupValue: controller
                                                  .selectedAddressIndex.value,
                                              activeColor: Colors.blue.shade800,
                                              onChanged: (value) {
                                                controller.selectedAddressIndex
                                                    .value = value as int;
                                              },
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${controller.savedAddressesController.savedDeliveryAddress[index]!.addressLine1}, ${controller.savedAddressesController.savedDeliveryAddress[index]!.addressLine2}",
                                          maxLines: 3,
                                          style: GoogleFonts.getFont(
                                            'Signika Negative',
                                            textStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: Get.width * 0.04,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          controller
                                              .savedAddressesController
                                              .savedDeliveryAddress[index]!
                                              .mobile,
                                          maxLines: 1,
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
                              ),
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.savedAddressesController
                                .savedDeliveryAddress.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                width: 10,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.02),
                      const Divider(),
                      Text(
                        "Select Payment Option",
                        style: GoogleFonts.getFont(
                          'Signika Negative',
                          fontSize: Get.width * 0.04,
                        ),
                      ),
                      const Divider(),
                      SizedBox(height: Get.height * 0.01),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, parentIndex) {
                            if (controller.checkoutImages[parentIndex]
                                        .checkoutCategory ==
                                    "Credit Card" &&
                                controller.savedCardsController
                                    .creditCardDetails.isNotEmpty) {
                              return Column(
                                children: [
                                  SizedBox(height: Get.height * 0.01),
                                  const Divider(),
                                  Text(
                                    "Credit Cards",
                                    style: GoogleFonts.getFont(
                                      'Signika Negative',
                                      fontSize: Get.width * 0.035,
                                    ),
                                  ),
                                  const Divider(),
                                  SizedBox(height: Get.height * 0.02),
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Obx(
                                          () => GestureDetector(
                                            onTap: () => controller
                                                    .selectedPaymentMethod
                                                    .value =
                                                "Credit Card: ${controller.savedCardsController.creditCardDetails[index].cardNumber}",
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 10,
                                                  top: 10),
                                              decoration: BoxDecoration(
                                                  border: controller
                                                              .savedCardsController
                                                              .creditCardDetails[index]
                                                              .cardNumber ==
                                                          controller.selectedPaymentMethod.value
                                                      ? Border.all(color: Colors.blue.shade800)
                                                      : null,
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 10)
                                                  ]),
                                              child: Row(
                                                children: [
                                                  CommonImageView(
                                                    height: 50,
                                                    width: 50,
                                                    fit: BoxFit.scaleDown,
                                                    url: controller
                                                        .checkoutImages[
                                                            parentIndex]
                                                        .imageUrl,
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    controller
                                                        .savedCardsController
                                                        .creditCardDetails[
                                                            index]
                                                        .cardNumber,
                                                    style: GoogleFonts.getFont(
                                                      'Signika Negative',
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            Get.width * 0.05,
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Obx(
                                                    () => Transform.scale(
                                                      scale: 1.3,
                                                      child: Radio(
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        value:
                                                            "Credit Card: ${controller.savedCardsController.creditCardDetails[index].cardNumber}",
                                                        activeColor: Colors
                                                            .blue.shade800,
                                                        groupValue: controller
                                                            .selectedPaymentMethod
                                                            .value,
                                                        onChanged: (value) {
                                                          controller
                                                                  .selectedPaymentMethod
                                                                  .value =
                                                              value.toString();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: 10,
                                          ),
                                      itemCount: controller.savedCardsController
                                          .creditCardDetails.length),
                                ],
                              );
                            }
                            return Obx(
                              () => GestureDetector(
                                onTap: () =>
                                    controller.selectedPaymentMethod.value =
                                        controller.checkoutImages[parentIndex]
                                            .checkoutCategory,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, bottom: 10, top: 10),
                                  decoration: BoxDecoration(
                                      border: controller
                                                  .checkoutImages[parentIndex]
                                                  .checkoutCategory ==
                                              controller
                                                  .selectedPaymentMethod.value
                                          ? Border.all(
                                              color: Colors.blue.shade800)
                                          : null,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10)
                                      ]),
                                  child: Row(
                                    children: [
                                      CommonImageView(
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.scaleDown,
                                        url: controller
                                            .checkoutImages[parentIndex]
                                            .imageUrl,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        controller.checkoutImages[parentIndex]
                                            .checkoutCategory,
                                        style: GoogleFonts.getFont(
                                          'Signika Negative',
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: Get.width * 0.05,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Obx(
                                        () => Transform.scale(
                                          scale: 1.3,
                                          child: Radio(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            value: controller
                                                .checkoutImages[parentIndex]
                                                .checkoutCategory,
                                            activeColor: Colors.blue.shade800,
                                            groupValue: controller
                                                .selectedPaymentMethod.value,
                                            onChanged: (value) {
                                              controller.selectedPaymentMethod
                                                  .value = value.toString();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: controller.checkoutImages.length),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        color: Colors.grey.shade300,
                        height: 1,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: controller.couponFormKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Get.width * 0.6,
                              decoration:
                                  AppDecoration.inputBoxDecorationShaddow(),
                              child: TextFormField(
                                  style: GoogleFonts.getFont('Signika Negative',
                                      fontSize: Get.width * 0.05),
                                  decoration: AppDecoration()
                                      .textInputDecoration(
                                          "Apply Coupon", 'Coupon Code'),
                                  focusNode: FocusNode(),
                                  controller: controller.couponController,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "Empty Coupon";
                                    }
                                    return null;
                                  }),
                            ),
                            Container(
                              height: 58,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(29)),
                                gradient: LinearGradient(colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade800
                                ]),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(4, 8),
                                    blurRadius: 20,
                                    color: const Color(0xFF101010)
                                        .withOpacity(0.25),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(29)),
                                  onTap: () {
                                    if (controller.couponFormKey.currentState!
                                        .validate()) {
                                      controller.validateCoupon();
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      'Apply',
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey.shade300,
                        height: 1,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 10)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Subtotal: ",
                                    style: GoogleFonts.getFont(
                                      'Signika Negative',
                                      fontSize: Get.width * 0.06,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "₹${controller.cartController.subTotal.value.toStringAsFixed(2)}",
                                    style: GoogleFonts.getFont(
                                      'Signika Negative',
                                      fontSize: Get.width * 0.06,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Shipping Charge: ",
                                    style: GoogleFonts.getFont(
                                      'Signika Negative',
                                      fontSize: Get.width * 0.06,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "₹${controller.cartController.shippingCharges.value.toStringAsFixed(2)}",
                                    style: GoogleFonts.getFont(
                                      'Signika Negative',
                                      fontSize: Get.width * 0.06,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Taxes: ",
                                    style: GoogleFonts.getFont(
                                      'Signika Negative',
                                      fontSize: Get.width * 0.06,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "₹${controller.cartController.taxes.value.toStringAsFixed(2)}",
                                    style: GoogleFonts.getFont(
                                      'Signika Negative',
                                      fontSize: Get.width * 0.06,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              if (controller.appliedCouponDiscount.value != 0)
                                Row(
                                  children: [
                                    Text(
                                      "Discount: ",
                                      style: GoogleFonts.getFont(
                                        'Signika Negative',
                                        fontSize: Get.width * 0.06,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "- ₹${((controller.cartController.subTotal.value * (controller.appliedCouponDiscount.value / 100))).toStringAsFixed(2)}",
                                      style: GoogleFonts.getFont(
                                        'Signika Negative',
                                        fontSize: Get.width * 0.06,
                                      ),
                                    )
                                  ],
                                ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                color: Colors.grey.shade300,
                                height: 1,
                                width: double.infinity,
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Pay: ",
                                    style: GoogleFonts.getFont(
                                        'Signika Negative',
                                        fontSize: Get.width * 0.06,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    "₹${controller.finalCheckoutPrice.value.toStringAsFixed(2)}",
                                    style: GoogleFonts.getFont(
                                        'Signika Negative',
                                        fontSize: Get.width * 0.06,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        color: Colors.grey.shade300,
                        height: 1,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(29)),
                          gradient: LinearGradient(colors: [
                            Colors.blue.shade400,
                            Colors.blue.shade800
                          ]),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(4, 8),
                              blurRadius: 20,
                              color: const Color(0xFF101010).withOpacity(0.25),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(29)),
                            onTap: () {
                              controller.uploadOrderToFirebase();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(placeOrder),
                                  color: Colors.white,
                                  fit: BoxFit.scaleDown,
                                  height: 40,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'Place Order',
                                  style: GoogleFonts.getFont(
                                    'Signika Negative',
                                    color: Colors.white,
                                    fontSize: Get.width * 0.06,
                                  ),
                                ),
                              ],
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
