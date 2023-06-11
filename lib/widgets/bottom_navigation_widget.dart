import 'package:shopexpress/core/app_export.dart';

import '../routes/app_routes.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  List<TabItem> items = [
    const TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    const TabItem(
      icon: Icons.manage_accounts,
      title: 'Search',
    ),
    const TabItem(
      icon: Icons.favorite_border,
      title: 'Wishlist',
    ),
    const TabItem(
      icon: Icons.shopping_cart_outlined,
      title: 'Cart',
    ),
    const TabItem(
      icon: Icons.account_box,
      title: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomBarSalomon(
      items: items,
      iconSize:  Get.width * 0.06,
      titleStyle: GoogleFonts.getFont('Signika Negative',
          fontSize: Get.width * 0.04, fontWeight: FontWeight.bold),
      backgroundColor: Colors.white,
      color: Colors.blue,
      colorSelected: Colors.white,
      indexSelected: selectedBottomNavigationIndex,
      onTap: (int index) => setState(() {
        _onItemTapped(index);
      }),
      animated: true,
      backgroundSelected: Colors.blue,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedBottomNavigationIndex = index;
      debugPrint("Selected Index :: $selectedBottomNavigationIndex");
      _navigateToScreens(selectedBottomNavigationIndex);
    });
  }

  void _navigateToScreens(int index) {
    if (index == 0) {
      debugPrint("Navigating to Home");
      Get.toNamed(AppRoutes.homeScreen);
    } else if (index == 1) {
      debugPrint("Navigating to Manage Account");
      Get.toNamed(AppRoutes.manageAccountScreen);
    } else if (index == 2) {
      debugPrint("Navigating to Favourite options");
      Get.toNamed(AppRoutes.searchProductScreen);
    } else if (index == 3) {
      debugPrint("Navigating Cart Options");
      Get.toNamed(AppRoutes.homeScreen);
    } else if (index == 4) {
      debugPrint("Navigating to Profile Options");
      Get.toNamed(AppRoutes.profileScreen);
    }
  }
}
