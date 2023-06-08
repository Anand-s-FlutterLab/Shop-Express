import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AppDecoration {
  static BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  static BoxDecoration inputBoxDecorationShadowWithBorder() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ],
    borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade400));
  }

  static BoxDecoration inputBoxDecorationShaddowDark() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  InputDecoration textInputDecoration(
      [String lableText = "", String hintText = ""]) {
    return InputDecoration(
      labelText: lableText,
      labelStyle:
          GoogleFonts.getFont('Signika Negative', fontSize: Get.width * 0.05),
      hintText: hintText,
      hintStyle:
          GoogleFonts.getFont('Signika Negative', fontSize: Get.width * 0.05),
      errorStyle:
          GoogleFonts.getFont('Signika Negative', fontSize: Get.width * 0.05),
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  InputDecoration textInputDecorationDark(
      [String lableText = "", String hintText = ""]) {
    return InputDecoration(
      labelText: lableText,
      labelStyle: GoogleFonts.getFont('Signika Negative', color: Colors.white),
      hintText: hintText,
      hintStyle: GoogleFonts.getFont('Signika Negative', color: Colors.white),
      errorStyle: GoogleFonts.getFont(
        'Signika Negative',
      ),
      fillColor: const Color(0xff111114),
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white54)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  static BoxDecoration innerShadow(double BR) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(BR),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff040039).withOpacity(.15),
        ),
        const BoxShadow(
          color: Colors.white,
          spreadRadius: -1.0,
          blurRadius: 10.0,
        ),
      ],
    );
  }

  static BoxDecoration innerShadowDark(double BR) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(BR),
      boxShadow: const [
        BoxShadow(color: Colors.white54, blurRadius: 5.0, spreadRadius: 1),
        BoxShadow(
          color: Colors.black,
        ),
      ],
    );
  }

  static BoxDecoration homeCard() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff040039).withOpacity(.15),
            blurRadius: 10,
          ),
        ]);
  }

  static BoxDecoration homeCardDark() {
    return BoxDecoration(
      // color: const Color(0xff111114),
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Colors.white54,
          blurRadius: 7,
        ),
      ],
    );
  }
  static BoxDecoration get primaryBoxDecoration => BoxDecoration(
    gradient: LinearGradient(
      begin: const Alignment(
        -1.4180527863061343e-9,
        -0.061403480546041056,
      ),
      end: const Alignment(
        1.000000006060046,
        1.114035163419933,
      ),
      colors: [
        Colors.blue.shade400,
        Colors.blue.shade800,
      ],
    ),
  );
}
