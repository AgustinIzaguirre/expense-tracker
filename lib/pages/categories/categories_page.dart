import 'package:expense_tracker/widgets/bottom_nav_bar.dart';
import 'package:expense_tracker/widgets/expense_tracker_app_bar.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {

  const CategoriesPage({super.key, required this.title});


  final String title;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  static const String CATEGORIES_TITLE = "Categories";
  static const String CATEGORIES_TOOLTIP = "Create category";
  
  BottomNavItem _currentTab = BottomNavItem.categories;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: ExpenseTrackerAppBar(onAddPressed: () {
          // TODO: navegar a CreateExpense
          // Navigator.push(...)
        },
        title: CATEGORIES_TITLE,
        tooltip: CATEGORIES_TOOLTIP,

      ),
      body: 
      SizedBox(width: 10,),
      bottomNavigationBar: AppBottomNavBar(
        current: _currentTab,
        onTap: (tab) {
          setState(() => _currentTab = tab);
        },
      ),
    );
  }
}