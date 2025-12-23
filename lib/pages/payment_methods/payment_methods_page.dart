import 'package:expense_tracker/widgets/bottom_nav_bar.dart';
import 'package:expense_tracker/widgets/expense_tracker_app_bar.dart';
import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {

  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  static const String PAYMENT_METHODS_TITLE = "Categories";
  static const String PAYMENT_METHODS_TOOLTIP = "Create category";
  
  BottomNavItem _currentTab = BottomNavItem.categories;

  @override
  Widget build(BuildContext context) {
   return SizedBox(width: 10,);
  }
}