import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/coupons_screen/model/coupons_model.dart';

class CouponsController extends GetxController {
  RxList<Coupons> coupons = <Coupons>[].obs;
  RxBool couponsLoading = false.obs;

  void onInit(){
    super.onInit();
    getCoupons();
  }

  Future<void> getCoupons() async {
    couponsLoading.value = true;
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionCoupons)
          .get();
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Coupons coupon = Coupons.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
        coupons.add(coupon);
      }
    } catch (error) {
      print(error);
      if (error is! StateError) {
        handleFirebaseError(error);
      }
    } finally {
      couponsLoading.value = false;
    }
  }
}
