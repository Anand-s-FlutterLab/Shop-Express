import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/orders_screen/controller/orders_controller.dart';

class OrderDetailsScreen extends GetWidget<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: MyPersistentHeaderDelegate(
                minHeight: 60.0,
                maxHeight: 100.0,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Order Details',
                      style: GoogleFonts.getFont(
                        'Signika Negative',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.047,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    buildTextRow(
                      title: "Order ID:",
                      text: controller.orderDetailsModel.orderID,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildTextRow(
                      title: "Ordered On:",
                      text: controller.orderDetailsModel.orderDate,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildTextRow(
                      title: "Order Total:",
                      text:
                          "₹${numberFormatter(controller.orderDetailsModel.orderTotal.toDouble())}",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildTextRow(
                      title: "Order Status:",
                      text: controller.orderDetailsModel.orderStatus,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildTextRow(
                      title: "Expected Delivery Date:",
                      text: controller.orderDetailsModel.expectedDeliveryDate,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: MyPersistentHeaderDelegate(
                minHeight: 60.0,
                maxHeight: 100.0,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Items in Order',
                      style: GoogleFonts.getFont(
                        'Signika Negative',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.047,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ListView.separated(
                  padding: EdgeInsets.all(10),
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 10)
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Row(
                          children: [
                            Center(
                              child: CommonImageView(
                                height: 120,
                                width: 120,
                                fit: BoxFit.scaleDown,
                                url: controller.orderDetailsModel.items[index]
                                    .displayImageLink,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: Get.width - 155,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      controller.orderDetailsModel.items[index]
                                          .productBrand,
                                      style: GoogleFonts.getFont(
                                        'Signika Negative',
                                        fontSize: Get.width * 0.03,
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      controller.orderDetailsModel.items[index]
                                          .productName,
                                      style: GoogleFonts.getFont(
                                        'Signika Negative',
                                        fontSize: Get.width * 0.04,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Ordered Quantity: ${controller.orderDetailsModel.items[index].productQuantity.value}",
                                    style: GoogleFonts.getFont(
                                      'Signika Negative',
                                      fontSize: Get.width * 0.04,
                                    ),
                                  ),
                                  Text(
                                    "Price: ₹${numberFormatter(controller.orderDetailsModel.items[index].productDisplayPrice)}",
                                    style: GoogleFonts.getFont(
                                      'Signika Negative',
                                      fontSize: Get.width * 0.04,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: controller.orderDetailsModel.totalItems),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: MyPersistentHeaderDelegate(
                minHeight: 60.0,
                maxHeight: 100.0,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Payment Details',
                      style: GoogleFonts.getFont(
                        'Signika Negative',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.047,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 10)
                        ]),
                    child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: controller.orderDetailsModel.paymentMethod.length > 10
                              ? Column(
                                  children: [
                                    buildTextRow(
                                        title: "Payment Mode: ",
                                        text: "Credit Card"),
                                    buildTextRow(
                                        title: "Card Number: ",
                                        text: controller
                                            .orderDetailsModel.paymentMethod
                                            .split("Credit Card: ")[1]),
                                    buildTextRow(
                                        title: "Transaction ID: ",
                                        text: controller
                                            .orderDetailsModel.transactionId)
                                  ],
                                )
                              : Column(
                                  children: [
                                    buildTextRow(
                                        title: "Payment Mode",
                                        text: controller
                                            .orderDetailsModel.paymentMethod),
                                    controller.orderDetailsModel.paymentMethod !=
                                            "COD"
                                        ? buildTextRow(
                                            title: "Transaction ID",
                                            text: controller
                                                .orderDetailsModel.transactionId)
                                        : SizedBox(),
                                  ],
                                ),
                        )),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: MyPersistentHeaderDelegate(
                minHeight: 60.0,
                maxHeight: 100.0,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Pricing Summary',
                      style: GoogleFonts.getFont(
                        'Signika Negative',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.047,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10)
                      ]),
                  child: Column(
                    children: [
                      Padding(
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
                                  "₹${numberFormatter(controller.orderDetailsModel.subTotal)}",
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
                                  "₹${numberFormatter(controller.orderDetailsModel.shippingCharges)}",
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
                                  "₹${numberFormatter(controller.orderDetailsModel.taxes)}",
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
                            if (controller
                                .orderDetailsModel.appliedCoupon.isNotEmpty)
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
                                    "- ₹${numberFormatter(controller.orderDetailsModel.subTotal - controller.orderDetailsModel.orderTotal)}",
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
                                  style: GoogleFonts.getFont('Signika Negative',
                                      fontSize: Get.width * 0.06,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  "₹${numberFormatter(controller.orderDetailsModel.orderTotal.toDouble())}",
                                  style: GoogleFonts.getFont('Signika Negative',
                                      fontSize: Get.width * 0.06,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  MyPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant MyPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

Widget buildTextRow({required String title, required String text}) {
  return Row(
    children: [
      SizedBox(
        width: Get.width * 0.41,
        child: Text(
          title,
          style: GoogleFonts.getFont(
            'Signika Negative',
            fontSize: Get.width * 0.047,
          ),
        ),
      ),
      SizedBox(
        width: Get.width * 0.51,
        child: Text(
          text,
          style: GoogleFonts.getFont(
            'Signika Negative',
            fontSize: Get.width * 0.047,
          ),
        ),
      ),
    ],
  );
}
