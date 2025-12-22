import 'package:expense_tracker/models/category.dart';
import 'package:flutter/material.dart';

final mockCategories = <Category>[
  Category(
    id: 1,
    name: 'Comida',
    iconCodePoint: Icons.restaurant.codePoint,
    iconFontFamily: Icons.restaurant.fontFamily!,
  ),
  Category(
    id: 2,
    name: 'Transporte',
    iconCodePoint: Icons.directions_bus.codePoint,
    iconFontFamily: Icons.directions_bus.fontFamily!,
  ),
  Category(
    id: 3,
    name: 'Salud',
    iconCodePoint: Icons.medical_services.codePoint,
    iconFontFamily: Icons.medical_services.fontFamily!,
  ),
  Category(
    id: 4,
    name: 'Hogar',
    iconCodePoint: Icons.home.codePoint,
    iconFontFamily: Icons.home.fontFamily!,
  ),
];
