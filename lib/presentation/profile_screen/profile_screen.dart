import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/profile_screen/controller/profile_controller.dart';

class ProfileScreen extends GetWidget<ProfileController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
      ),
      body: SafeArea(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }

}