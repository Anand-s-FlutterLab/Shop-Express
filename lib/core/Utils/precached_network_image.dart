import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopexpress/core/app_export.dart';

Future<void> preCacheFirebaseImage(BuildContext context) async {
  List<String> imgUrls = [
    "https://firebasestorage.googleapis.com/v0/b/shopexpress-990f2.appspot.com/o/Genaral%20Image%2FnoResultFound.gif?alt=media&token=cd4e7c38-077e-41e4-ae50-1cd5568f05e0",
    "https://firebasestorage.googleapis.com/v0/b/shopexpress-990f2.appspot.com/o/Genaral%20Image%2FemptyCart.png?alt=media&token=d3c81bf7-6c94-48b7-adaf-3e113f70d8d1",
    "https://firebasestorage.googleapis.com/v0/b/shopexpress-990f2.appspot.com/o/Genaral%20Image%2FmanageItemSlider.png?alt=media&token=7a48254a-4e2e-4242-86e3-3aff96993f26",
    "https://firebasestorage.googleapis.com/v0/b/shopexpress-990f2.appspot.com/o/Genaral%20Image%2FaddProduct.png?alt=media&token=eb1d8e5d-bc79-4ee3-994c-955a925f0d01",
    "https://firebasestorage.googleapis.com/v0/b/shopexpress-990f2.appspot.com/o/Genaral%20Image%2FproductManagement.png?alt=media&token=0cfb4bc2-0d3f-4f76-bb55-1b3a9e772bf0",
    "https://firebasestorage.googleapis.com/v0/b/shopexpress-990f2.appspot.com/o/Genaral%20Image%2FnothingFavorite.png?alt=media&token=5fb5fac6-2d5f-4a23-bb7c-3fa4648fa055",
    "https://firebasestorage.googleapis.com/v0/b/shopexpress-990f2.appspot.com/o/Genaral%20Image%2FnointernetConnection.png?alt=media&token=0610c047-0b27-4999-ac05-7611b4ac22b9",
    "https://firebasestorage.googleapis.com/v0/b/shopexpress-990f2.appspot.com/o/Genaral%20Image%2FdefaultProfile.png?alt=media&token=f50dd430-c012-4902-88e8-89753c0c89f7",
  ];
  try {
    for (String url in imgUrls) {
      precacheImage(CachedNetworkImageProvider(url), context);
    }
    isImagePrecached.value = true;
  } catch (e) {
    print(e);
  }
}
