import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final int iconCodePoint;
  final String iconFontFamily;
  
  const Category({required this.id, required this.name, required this.iconCodePoint, required this.iconFontFamily});

  IconData get icon => IconData(
    iconCodePoint,
    fontFamily: iconFontFamily,
  );

}