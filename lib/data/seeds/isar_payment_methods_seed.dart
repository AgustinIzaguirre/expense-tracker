import 'package:expense_tracker/infraestructure/isar_instance.dart';
import 'package:flutter/material.dart';
import '../../daos/payment_method.dart' as dao;

class IsarPaymentMethodsSeed {
  static Future<void> seedIfEmpty() async {
    final isar = IsarInstance.isar;

    final existingCount = await isar.paymentMethods.count();
    if (existingCount > 0) return;

    final defaults = <dao.PaymentMethod>[
      dao.PaymentMethod()
        ..name = 'Cash'
        ..iconCodePoint = Icons.restaurant.codePoint
        ..iconFontFamily = Icons.restaurant.fontFamily!,
       dao.PaymentMethod()
        ..name = 'Credit Card'
        ..iconCodePoint = Icons.restaurant.codePoint
        ..iconFontFamily = Icons.restaurant.fontFamily!,
    ];

    await isar.writeTxn(() async {
      await isar.paymentMethods.putAll(defaults);
    });
  }
}
