import 'package:flutter/material.dart';

class PaymentMethod {
  final int id;
  final String name;
  final int iconCodePoint;
  final String iconFontFamily;

  const PaymentMethod({required this.id, required this.name, required this.iconCodePoint, required this.iconFontFamily});
  
   IconData get icon => IconData(
    iconCodePoint,
    fontFamily: iconFontFamily,
  );
}