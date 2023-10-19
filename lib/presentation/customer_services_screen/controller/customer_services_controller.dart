import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/customer_services_screen/model/customer_services_model.dart';

class CustomerSupportController extends GetxController {
  late CustomerSupportModel customerSupportModel;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCustomerSupportData();
  }

  Future<void> getCustomerSupportData() async {
    isLoading.value = true;
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(collectionCustomerSupport)
          .doc('1')
          .get();

      customerSupportModel = CustomerSupportModel.fromJson(
          snapshot.data() as Map<String, dynamic>);
      isLoading.value = false;
    } catch (error) {
      handleFirebaseError(error);
    }
  }
}
