import 'package:shopexpress/presentation/cart_screen/controller/cart_controller.dart';
import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/widgets/bottom_navigation_widget.dart';
import 'package:shopexpress/widgets/common_image_view.dart';

import '../../widgets/counter_button.dart';

class CartScreen extends StatelessWidget {
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Cart",
          style: GoogleFonts.getFont(
            'Signika Negative',
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: Get.width * 0.07,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: Get.height - 100,
        child: Obx(
          () => controller.cartItems.isEmpty
              ? SizedBox(
                  height: Get.height - 170,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImageView(
                        url: emptyCartUrl,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "Your Cart is Waiting to be Filled",
                            maxLines: 1,
                            style: GoogleFonts.getFont(
                              'Signika Negative',
                              color: Colors.grey,
                              fontSize: Get.width * 0.07,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        AnimationLimiter(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: controller.cartItems.length,
                            itemBuilder: (context, index) {
                              controller.cartItems[index].productFinalPrice
                                  .value = (controller
                                      .cartItems[index].productDisplayPrice *
                                  controller
                                      .cartItems[index].productQuantity.value);
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  duration: Duration(milliseconds: 1050),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  verticalOffset: -250,
                                  child: ScaleAnimation(
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 10)
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  padding: EdgeInsets.all(2),
                                                  child: CommonImageView(
                                                    url: controller
                                                        .cartItems[index]
                                                        .displayImageLink,
                                                    fit: BoxFit.contain,
                                                    height: 150,
                                                    width: 150,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .cartItems[index]
                                                              .productBrand,
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Signika Negative',
                                                            fontSize:
                                                                Get.width *
                                                                    0.04,
                                                          ),
                                                        ),
                                                        Text(
                                                          controller
                                                              .cartItems[index]
                                                              .productName,
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Signika Negative',
                                                            fontSize:
                                                                Get.width *
                                                                    0.06,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children: [
                                                            CounterButton(
                                                              icon: const Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .blue),
                                                              onItemSelected:
                                                                  () {
                                                                if (controller
                                                                        .cartItems[
                                                                            index]
                                                                        .productQuantity >
                                                                    1) {
                                                                  controller
                                                                      .cartItems[
                                                                          index]
                                                                      .productQuantity -= 1;
                                                                  controller
                                                                      .updateProductFinalPrice(
                                                                          index);
                                                                  controller
                                                                      .updateCartTotal();
                                                                } else {
                                                                  controller
                                                                      .removeItemFromCart(
                                                                          index);
                                                                }
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 35,
                                                              width: 35,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            6.0),
                                                                child: Obx(
                                                                  () =>
                                                                      TextFormField(
                                                                    controller: controller
                                                                        .cartItems[
                                                                            index]
                                                                        .cartQuantityController
                                                                      ..text = controller
                                                                          .cartItems[
                                                                              index]
                                                                          .productQuantity
                                                                          .value
                                                                          .toString(),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    decoration:
                                                                        const InputDecoration
                                                                            .collapsed(
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors
                                                                              .white,
                                                                      hintText:
                                                                          '',
                                                                    ),
                                                                    style: GoogleFonts
                                                                        .getFont(
                                                                      'Signika Negative',
                                                                      fontSize:
                                                                          Get.width *
                                                                              0.055,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            CounterButton(
                                                              isLeftButton:
                                                                  false,
                                                              icon: const Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .blue),
                                                              onItemSelected:
                                                                  () {
                                                                controller
                                                                    .cartItems[
                                                                        index]
                                                                    .productQuantity += 1;
                                                                controller
                                                                    .updateProductFinalPrice(
                                                                        index);
                                                                controller
                                                                    .updateCartTotal();
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Obx(
                                                          () => Text(
                                                            "₹ ${controller.cartItems[index].productFinalPrice.value.toStringAsFixed(2)}",
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Signika Negative',
                                                              fontSize:
                                                                  Get.width *
                                                                      0.055,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller
                                                  .removeItemFromCart(index);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red.shade50,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(36),
                                                  topRight: Radius.circular(36),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10.0, 10, 10, 5),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
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
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 10)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(
                              () => Column(
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
                                        "₹${controller.subTotal.value.toStringAsFixed(2)}",
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
                                        "₹${controller.shippingCharges.value.toStringAsFixed(2)}",
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
                                        "₹${controller.taxes.value.toStringAsFixed(2)}",
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
                                        "Total (Including Tax)",
                                        style: GoogleFonts.getFont(
                                            'Signika Negative',
                                            fontSize: Get.width * 0.06,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        "₹${controller.orderTotal.value.toStringAsFixed(2)}",
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
                                color:
                                    const Color(0xFF101010).withOpacity(0.25),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(29)),
                              onTap: () {
                                Get.toNamed(AppRoutes.checkoutScreen);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_checkout_rounded,
                                    color: Colors.white,
                                    size: Get.width * 0.07,
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    'Checkout',
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
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
