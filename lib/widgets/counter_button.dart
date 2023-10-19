import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final Function() onItemSelected;
  final Icon icon;
  final bool isLeftButton;
  final double height;

  const CounterButton({
    Key? key,
    required this.icon,
    required this.onItemSelected,
    this.isLeftButton = true,
    this.height = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = isLeftButton
        ? EdgeInsets.only(left: height / 10)
        : EdgeInsets.only(right: height / 10);

    final borderRadius = isLeftButton
        ? const BorderRadius.only(
            topLeft: Radius.circular(36),
            bottomLeft: Radius.circular(36),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(36),
            bottomRight: Radius.circular(36),
          );

    return GestureDetector(
      onTap: onItemSelected,
      child: Container(
        width: height,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: borderRadius,
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Padding(
            padding: padding,
            child: Align(
              alignment: Alignment.center,
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
