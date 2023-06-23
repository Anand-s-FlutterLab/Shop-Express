import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/orders_screen/controller/orders_controller.dart';

class OrdersScreen extends GetWidget<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Orders",
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
      body: Obx(() => controller.isLoading.value
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.blue, size: 50),
            )
          : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  Obx(
                    () => controller.orderModel.isEmpty
                        ? SizedBox(
                            height: Get.height - 150,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonImageView(
                                    url: noOrdersFound,
                                    fit: BoxFit.scaleDown,
                                    height: 350,
                                    width: 350,
                                  ),
                                  Text(
                                    "No Orders Found",
                                    style: GoogleFonts.getFont(
                                      'Signika Negative',
                                      textStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: Get.width * 0.05,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.all(15),
                            itemBuilder: (context, parentIndex) {
                              return GestureDetector(
                                onTap: (){
                                  controller.orderDetailsModel = controller.orderModel[parentIndex];
                                  Get.toNamed(AppRoutes.orderDetailsScreen);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 5)
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 8, 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                      .orderModel[parentIndex]
                                                      .orderID,
                                                  style: GoogleFonts.getFont(
                                                    'Signika Negative',
                                                    textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: Get.width * 0.05,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: deliveryDate(
                                                        parentIndex)),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Total Items: ${controller.orderModel[parentIndex].totalItems}",
                                                  style: GoogleFonts.getFont(
                                                    'Signika Negative',
                                                    textStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: Get.width * 0.04,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child:
                                                      paymentOption(parentIndex),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Colors.grey.shade200,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            height: Get.height * 0.12,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15)),
                                            ),
                                            child: ListView.separated(
                                              shrinkWrap: false,
                                              padding: EdgeInsets.all(2),
                                              scrollDirection: Axis.horizontal,
                                              physics: BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    globalProductID.value = controller.orderModel[parentIndex].items[index].productId;
                                                    Get.toNamed(AppRoutes.productDetailScreen);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade400),
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8)),
                                                    child: CommonImageView(
                                                      url: controller
                                                          .orderModel[parentIndex]
                                                          .items[index]
                                                          .displayImageLink,
                                                      fit: BoxFit.scaleDown,
                                                      height: Get.height * 0.11,
                                                      width: Get.width * 0.25,
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                width: 10,
                                              ),
                                              itemCount: controller
                                                  .orderModel[parentIndex]
                                                  .totalItems,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    deliveryStatus(parentIndex),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                            itemCount: controller.orderModel.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                  )
                ],
              ),
            )),
    );
  }

  Widget deliveryStatus(int index) {
    late Color decorationColor;
    late Color fontColor;
    if (controller.orderModel[index].orderStatus == "Cancelled") {
      decorationColor = Colors.red.shade100;
      fontColor = Colors.red.shade600;
    }
    if (controller.orderModel[index].orderStatus == "In Transit") {
      decorationColor = Colors.blue.shade100;
      fontColor = Colors.blue.shade600;
    }
    if (controller.orderModel[index].orderStatus == "Delivered") {
      decorationColor = Colors.green.shade100;
      fontColor = Colors.green.shade600;
    }
    if (controller.orderModel[index].orderStatus == "Placed") {
      decorationColor = Colors.blueGrey.shade100;
      fontColor = Colors.blueGrey.shade700;
    }
    return Positioned(
      top: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
        child: Container(
          padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
          decoration: BoxDecoration(color: decorationColor),
          child: Text(
            controller.orderModel[index].orderStatus,
            style: GoogleFonts.getFont(
              'Signika Negative',
              fontWeight: FontWeight.bold,
              color: fontColor,
              fontSize: Get.width * 0.04,
            ),
          ),
        ),
      ),
    );
  }

  Widget deliveryDate(int index) {
    late String deliveryLabel;
    if (controller.orderModel[index].orderStatus == "Cancelled") {
      deliveryLabel = "Cancelled On";
    }
    if (controller.orderModel[index].orderStatus == "In Transit" ||
        (controller.orderModel[index].orderStatus == "Placed")) {
      deliveryLabel = "Expected Delivery Date";
    }
    if (controller.orderModel[index].orderStatus == "Delivered") {
      deliveryLabel = "Delivered On";
    }
    return Text(
      "$deliveryLabel: ${controller.orderModel[index].expectedDeliveryDate}",
      style: GoogleFonts.getFont(
        'Signika Negative',
        textStyle: TextStyle(
          color: Colors.grey,
          fontSize: Get.width * 0.04,
        ),
      ),
    );
  }

  Widget paymentOption(int index) {
    if (controller.orderModel[index].paymentMethod.length > 20) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Mode: Credit Card",
            style: GoogleFonts.getFont(
              'Signika Negative',
              textStyle: TextStyle(
                color: Colors.grey,
                fontSize: Get.width * 0.04,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Amount: ₹${numberFormatter(controller.orderModel[index].orderTotal.toDouble())}",
            style: GoogleFonts.getFont(
              'Signika Negative',
              textStyle: TextStyle(
                color: Colors.grey,
                fontSize: Get.width * 0.04,
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Mode: ${controller.orderModel[index].paymentMethod}",
            style: GoogleFonts.getFont(
              'Signika Negative',
              textStyle: TextStyle(
                color: Colors.grey,
                fontSize: Get.width * 0.04,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Amount: ₹${numberFormatter(controller.orderModel[index].orderTotal.toDouble())}",
            style: GoogleFonts.getFont(
              'Signika Negative',
              textStyle: TextStyle(
                color: Colors.grey,
                fontSize: Get.width * 0.04,
              ),
            ),
          ),
        ],
      );
    }
  }
}
