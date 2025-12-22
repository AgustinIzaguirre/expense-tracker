
import 'package:expense_tracker/models/currency.dart';
import 'package:expense_tracker/pages/categories/categories_page.dart';
import 'package:expense_tracker/pages/payment_methods/payment_methods_page.dart';
import 'package:expense_tracker/widgets/bottom_nav_bar.dart';
import 'package:expense_tracker/widgets/expense_tracker_app_bar.dart';
import 'package:flutter/material.dart';

import 'expenses/expenses_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String EXPENSES_TITLE = "Expenses";
  static const String EXPENSES_TOOLTIP = "Create expense";
  
  static const String CATEGORIES_TITLE = "Categories";
  static const String CATEGORIES_TOOLTIP = "Create Category";
  
  static const String PAYMENT_METHODS_TITLE = "Payment Methods";
  static const String PAYMENT_METHODS_TOOLTIP = "Create payment method";
  
  BottomNavItem _currentTab = BottomNavItem.expenses;

  @override
  Widget build(BuildContext context) {
    Currency currency = Currency.ars;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: AppBottomNavBar(
        current: _currentTab,
        onTap: (tab) {
          print(tab);
          setState(() => _currentTab = tab);
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentTab) {
      case BottomNavItem.expenses:
        return const ExpensesPage();
      case BottomNavItem.paymentMethods:
        return const PaymentMethodsPage();
      case BottomNavItem.categories:
        return const CategoriesPage();
    }
  }

  PreferredSizeWidget _buildAppBar() {
    switch (_currentTab) {
      case BottomNavItem.expenses:
       return  ExpenseTrackerAppBar(onAddPressed: () {
            // TODO: navegar a CreateExpense
            // Navigator.push(...)
          },
          title: EXPENSES_TITLE,
          tooltip: EXPENSES_TOOLTIP,
        );
      case BottomNavItem.paymentMethods:
        return  ExpenseTrackerAppBar(onAddPressed: () {
            // TODO: navegar a CreateExpense
            // Navigator.push(...)
          },
          title: PAYMENT_METHODS_TITLE,
          tooltip: PAYMENT_METHODS_TOOLTIP,
        );
      case BottomNavItem.categories:
        return  ExpenseTrackerAppBar(onAddPressed: () {
            // TODO: navegar a CreateExpense
            // Navigator.push(...)
          },
          title: CATEGORIES_TITLE,
          tooltip: CATEGORIES_TOOLTIP,
        );
    }
  }
}
