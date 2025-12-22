import 'package:expense_tracker/pages/categories/icons_catalog.dart';
import 'package:flutter/material.dart';

Future<IconData?> showCategoryIconPicker(
  BuildContext context, {
  IconData? selected,
}) {
  return showModalBottomSheet<IconData>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (_) => _IconPickerSheet(selected: selected),
  );
}

class _IconPickerSheet extends StatelessWidget {
  final IconData? selected;
  const _IconPickerSheet({this.selected});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Elegí un ícono',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: categoryIcons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, i) {
                final icon = categoryIcons[i];
                final isSelected = selected != null &&
                    icon.codePoint == selected!.codePoint &&
                    icon.fontFamily == selected!.fontFamily;

                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => Navigator.pop(context, icon),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: isSelected ? 2 : 1,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).dividerColor,
                      ),
                    ),
                    child: Icon(icon),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
