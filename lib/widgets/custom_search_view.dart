import 'package:shopexpress/core/app_export.dart';

import '../routes/app_routes.dart';

class CustomSearchView extends StatelessWidget {
  CustomSearchView(
      {Key? key,
        this.shape,
        this.padding,
        this.variant,
        this.fontStyle,
        this.alignment,
        this.width,
        this.margin,
        this.controller,
        this.focusNode,
        this.hintText,
        this.prefix,
        this.prefixConstraints,
        this.suffix,
        this.doAutoFocus,
        this.suffixConstraints})
      : super(key: key);

  SearchViewShape? shape;

  SearchViewPadding? padding;

  SearchViewVariant? variant;

  SearchViewFontStyle? fontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;

  FocusNode? focusNode;

  String? hintText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;

  bool? doAutoFocus;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: _buildSearchViewWidget(),
    )
        : _buildSearchViewWidget();
  }

  _buildSearchViewWidget() {
    return Container(
      width: Get.width,
      margin: margin,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: doAutoFocus ?? false,
        style: _setFontStyle(),
        decoration: _buildDecoration(),
        onTap: () => {Get.toNamed(AppRoutes.searchProductScreen)},
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      default:
        return TextStyle(
          color: Colors.grey.shade600,
          fontSize: 18,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      default:
        return BorderRadius.circular(
          8
        );
    }
  }

  _setBorderStyle() {
    switch (variant) {
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: Colors.grey.shade600,
            width: 1,
          ),
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      default:
        return Colors.white;
    }
  }

  _setFilled() {
    switch (variant) {
      case SearchViewVariant.FillOrangeA20063:
        return true;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      default:
        return EdgeInsets.all(10.0);
    }
  }
}

enum SearchViewShape {
  RoundedBorder15,
}

enum SearchViewPadding {
  PaddingAll15,
}

enum SearchViewVariant {
  FillOrangeA20063,
}

enum SearchViewFontStyle {
  RobotoRegular12,
}