import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

int selectedBottomNavigationIndex = 0;
RxString globalProductID = "".obs;
RxString selectedCategory = "All Products".obs;
RxBool isSpecialOfferSelected = false.obs;
RxString customSearch = "".obs;
RxBool isImagePrecached = false.obs;
RxInt cartItemNumber = 0.obs;
RxBool isAdmin = false.obs;
RxString userName = "".obs;
RxString userID = "".obs;

final Map<String, List<int>> categoryRanges = {
  'Mobile': [100001, 109999],
  'Speaker': [110001, 119999],
  'Smart Watch': [120001, 129999],
  'Laptop': [130001, 139999],
  'Headphones': [140001, 149999],
  'TV': [150001, 159999],
  'Power Bank': [160001, 169999],
  'Earphones': [170001, 179999],
  'All Products': [0, 999999],
  'Special Offer': [0, 999999]
};
