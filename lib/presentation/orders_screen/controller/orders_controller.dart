import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/orders_screen/model/orders_model.dart';

class OrdersController extends GetxController {
  RxList<OrderModel> orderModel = <OrderModel>[].obs;
  RxBool isLoading = false.obs;
  late OrderModel orderDetailsModel;

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  Future<void> getOrders() async {
    isLoading.value = true;
    try {
      final DocumentReference docRef = FirebaseFirestore.instance
          .collection(collectionUsers)
          .doc(userID.value);
      await docRef.get().then((value) {
        List ordersSnapshot = value.get(collectionOrders) ?? [];
        orderModel.clear();

        if (ordersSnapshot.isNotEmpty) {
          for (var i = 0; i < ordersSnapshot.length; i++) {
            OrderModel orders = OrderModel.fromJson(ordersSnapshot[i]);
            orderModel.add(orders);
          }
        }
      });
    } catch (error) {
      print(error);
      if (error is! StateError) {
        handleFirebaseError(error);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
