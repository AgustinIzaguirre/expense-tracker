
import 'package:expense_tracker/data/seeds/isar_categories_seed.dart';
import 'package:expense_tracker/data/seeds/isar_payment_methods_seed.dart';
import 'package:expense_tracker/infraestructure/isar_instance.dart';
import 'package:expense_tracker/pages/home_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarInstance.init();
  await IsarCategorySeed.seedIfEmpty();
  await IsarPaymentMethodsSeed.seedIfEmpty();

  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

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
      home: const HomePage(),
    );
  }
}