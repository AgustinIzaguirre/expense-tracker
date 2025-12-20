import 'package:flutter/material.dart';

class ExpensesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddPressed;

  const ExpensesAppBar({
    super.key,
    required this.onAddPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 2,
      title: const Text(
        'Expenses',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Agregar gasto',
          onPressed: onAddPressed,
        ),
      ],
    );
  }
}
