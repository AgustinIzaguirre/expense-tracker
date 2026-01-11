import 'package:isar/isar.dart';
import 'package:flutter/material.dart';

part 'payment_method.g.dart';

@collection
class PaymentMethod {
  Id id = Isar.autoIncrement;

  late String name;

  late int iconCodePoint;
  late String iconFontFamily;

  @ignore
  IconData get icon => IconData(
        iconCodePoint,
        fontFamily: iconFontFamily,
      );
}
