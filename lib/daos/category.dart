import 'package:isar/isar.dart';
import 'package:flutter/material.dart';

part 'category.g.dart';

@collection
class Category {
  Id id = Isar.autoIncrement;

  late String name;

  // Serializable (lo que elegirá el usuario)
  late int iconCodePoint;
  late String iconFontFamily;

  @ignore
  IconData get icon => IconData(
        iconCodePoint,
        fontFamily: iconFontFamily,
      );
}
