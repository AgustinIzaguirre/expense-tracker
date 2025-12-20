import 'dart:math';

import 'package:expense_tracker/models/Expense.dart';
import 'package:expense_tracker/models/cathegory.dart';
import 'package:expense_tracker/models/group_by.dart';
import 'package:expense_tracker/models/payment_method.dart';
import 'package:expense_tracker/pages/expenses/expenses_page.dart';
import 'package:expense_tracker/widgets/expense_card.dart';
import 'package:expense_tracker/pages/expenses/expenses_header.dart';
import 'package:expense_tracker/widgets/pie_chart/pie_chart_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExpensesPage(title: 'Expense Tracker'),
    );
  }
}