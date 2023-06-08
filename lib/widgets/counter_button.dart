import 'package:shopexpress/core/app_export.dart';

class CounterButton extends StatelessWidget {
  final Function() onItemSelected;
  final Icon icon;

  const CounterButton({
    Key? key,
    required this.icon,
    required this.onItemSelected,
  }) : super(key: key);

  Widget button(Icon icon, Function() onTap) {
    return RawMaterialButton(
      constraints: BoxConstraints.tight(const Size(36, 36)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      fillColor: Colors.blue,
      onPressed: () => onTap(),
      child: icon,
    );
  }

  Widget body() {
    return button(icon, onItemSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [body()]);
  }
}