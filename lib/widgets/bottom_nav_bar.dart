import 'package:flutter/material.dart';

enum BottomNavItem {
  expenses,
  paymentMethods,
  categories,
}

class AppBottomNavBar extends StatelessWidget {
  final BottomNavItem current;
  final ValueChanged<BottomNavItem> onTap;

  const AppBottomNavBar({
    super.key,
    required this.current,
    required this.onTap,
  });

  int _indexFromItem(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.expenses:
        return 0;
      case BottomNavItem.paymentMethods:
        return 1;
      case BottomNavItem.categories:
        return 2;
    }
  }

  BottomNavItem _itemFromIndex(int index) {
    switch (index) {
      case 0:
        return BottomNavItem.expenses;
      case 1:
        return BottomNavItem.paymentMethods;
      case 2:
        return BottomNavItem.categories;
      default:
        return BottomNavItem.expenses;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _indexFromItem(current),
      onTap: (i) => onTap(_itemFromIndex(i)),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Expenses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card),
          label: 'Payment',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
      ],
    );
  }
}
