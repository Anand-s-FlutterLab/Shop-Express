import 'package:shopexpress/core/app_export.dart';

SnackbarController customSnackBar(String title, String subtitle,
    [String colorSelector = "red"]) {
  Map<String, Color> colors = {
    'red': Colors.red,
    'green': Colors.green,
    'blue': Colors.blue,
  };
  Color? color = colors[colorSelector];
  return Get.snackbar(
    title,
    subtitle,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color!.withOpacity(0.2),
    barBlur: 10.0,
    borderRadius: 20,
    margin: const EdgeInsets.all(15),
    colorText: color,
    overlayBlur: 1.5,
    snackStyle: SnackStyle.FLOATING,
    duration: const Duration(seconds: 3),
    forwardAnimationCurve: Curves.decelerate,
    titleText: Text(
      title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
    messageText: Text(
      subtitle,
      style: TextStyle(
        fontSize: 15.0,
        color: color,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

