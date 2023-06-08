import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/home_screen/controller/home_controller.dart';
import 'package:shopexpress/widgets/bottom_navigation_widget.dart';

class HomeScreen extends GetWidget<HomeScreenController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("Home Screen"),
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }

}