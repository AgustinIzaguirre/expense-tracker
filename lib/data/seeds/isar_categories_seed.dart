import 'package:expense_tracker/infraestructure/isar_instance.dart';
import 'package:flutter/material.dart';
import '../../daos/category.dart' as dao;

class IsarCategorySeed {
  static Future<void> seedIfEmpty() async {
    final isar = IsarInstance.isar;

    final existingCount = await isar.categorys.count();
    if (existingCount > 0) return;

    // Tus categorías “default” (equivalentes a categories_mock.dart)
    final defaults = <dao.Category>[
      dao.Category()
        ..name = 'Food'
        ..iconCodePoint = Icons.restaurant.codePoint
        ..iconFontFamily = Icons.restaurant.fontFamily!,
      dao.Category()
        ..name = 'Transport'
        ..iconCodePoint = Icons.directions_bus.codePoint
        ..iconFontFamily = Icons.directions_bus.fontFamily!,
      dao.Category()
        ..name = 'Health'
        ..iconCodePoint = Icons.medical_services.codePoint
        ..iconFontFamily = Icons.medical_services.fontFamily!,
      dao.Category()
        ..name = 'Home'
        ..iconCodePoint = Icons.home.codePoint
        ..iconFontFamily = Icons.home.fontFamily!,
    ];

    await isar.writeTxn(() async {
      await isar.categorys.putAll(defaults);
    });
  }
}
