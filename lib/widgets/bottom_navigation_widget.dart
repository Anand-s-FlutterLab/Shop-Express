import 'package:shopexpress/core/app_export.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  DateTime? currentBackPressTime;

  List<TabItem> adminItems = [
    const TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    const TabItem(
      icon: Icons.manage_accounts,
      title: 'Management',
    ),
    const TabItem(
      icon: Icons.favorite_border,
      title: 'Beloved Picks',
    ),
    TabItem(
      icon: Icons.shopping_cart_outlined,
      title: 'Cart',
      count: Obx(
        () => cartItemNumber.value > 0
            ? Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    cartItemNumber.value.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : SizedBox(),
      ),
    ),
    const TabItem(
      icon: Icons.account_box,
      title: 'Profile',
    ),
  ];

  List<TabItem> userItems = [
    const TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    const TabItem(
      icon: Icons.favorite_border,
      title: 'Beloved Picks',
    ),
    TabItem(
      icon: Icons.shopping_cart_outlined,
      title: 'Cart',
      count: Obx(
        () => cartItemNumber.value > 0
            ? Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    cartItemNumber.value.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : SizedBox(),
      ),
    ),
    const TabItem(
      icon: Icons.account_box,
      title: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: BottomBarSalomon(
        items: isAdmin.value ? adminItems : userItems,
        iconSize: Get.width * 0.06,
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
      ),
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
      Get.offNamed(AppRoutes.homeScreen);
    } else if (index == 1) {
      debugPrint("Navigating to Manage Account");
      Get.offNamed(AppRoutes.manageAccountScreen);
    } else if (index == 2) {
      debugPrint("Navigating to Favourite options");
      Get.offNamed(AppRoutes.favoriteScreen);
    } else if (index == 3) {
      debugPrint("Navigating Cart Options");
      Get.offNamed(AppRoutes.cartScreen);
    } else if (index == 4) {
      debugPrint("Navigating to Profile Options");
      Get.offNamed(AppRoutes.profileScreen);
    }
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back button twice to exit'),
        ),
      );
      return Future.value(false);
    }
    print("exited");
    return Future.value(true);
  }
}
