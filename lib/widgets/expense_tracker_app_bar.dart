import 'package:flutter/material.dart';

class ExpenseTrackerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAddPressed;
  final String title;
  final String tooltip;

  const ExpenseTrackerAppBar({
    super.key,
    required this.onAddPressed,
    required this.title,
    required this.tooltip
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 2,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Tooltip(
          message: tooltip,
          triggerMode: TooltipTriggerMode.longPress, // <-- se ve con tap
          waitDuration: const Duration(milliseconds: 150),
          showDuration: const Duration(seconds: 2),
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAddPressed,
          ),
        ),
      ],
    );
  }
}
