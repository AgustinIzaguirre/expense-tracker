import 'package:expense_tracker/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {

  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  static const String CATEGORIES_TITLE = "Categories";
  static const String CATEGORIES_TOOLTIP = "Create category";
  
  BottomNavItem _currentTab = BottomNavItem.categories;

  @override
  Widget build(BuildContext context) {
   return SizedBox(width: 10,);
  }
}