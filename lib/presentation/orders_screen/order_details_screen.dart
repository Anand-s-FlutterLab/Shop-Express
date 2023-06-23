import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/orders_screen/controller/orders_controller.dart';

class OrderDetailsScreen extends GetWidget<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(controller.orderDetailsModel.orderID),
            Text(controller.orderDetailsModel.paymentMethod),
            Text(controller.orderDetailsModel.orderStatus),
            Text(controller.orderDetailsModel.expectedDeliveryDate),
          ],
        ),
      ),
    );
  }
}
