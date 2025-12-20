import 'package:expense_tracker/models/currency.dart';
import 'package:expense_tracker/models/group_by.dart';
import 'package:flutter/material.dart';

class ExpensesHeader extends StatelessWidget {
  final DateTimeRange range;
  final GroupBy groupBy;
  final Currency currency;
  final VoidCallback onPickRange;
  final ValueChanged<GroupBy> onChangeGroupBy;
  final ValueChanged<Currency> onChangeCurrency;

  const ExpensesHeader({
    super.key,
    required this.range,
    required this.groupBy,
    required this.currency,
    required this.onPickRange,
    required this.onChangeGroupBy,
    required this.onChangeCurrency,
  });

 @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    child: Column(
      children: [
        // ───── FILA 1: DATE RANGE ─────
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onPickRange,
                icon: const Icon(Icons.date_range),
                label: Text('${_formatDate(range.start)} - ${_formatDate(range.end)}'),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),
        Row(
          children: [
            SegmentedButton<GroupBy>(
              segments: const [
                ButtonSegment(
                  value: GroupBy.category,
                  label: Text('Categories'),
                  icon: Icon(Icons.pie_chart),
                ),
                ButtonSegment(
                  value: GroupBy.paymentMethod,
                  label: Text('Payment methods'),
                  icon: Icon(Icons.credit_card),
                ),
              ],
              selected: {groupBy},
              onSelectionChanged: (s) => onChangeGroupBy(s.first),
            ),

            const SizedBox(width: 12),

            DropdownButton<Currency>(
              value: currency,
              onChanged: (c) {
                if (c != null) onChangeCurrency(c);
              },
              items: Currency.values.map((c) {
                return DropdownMenuItem(
                  value: c,
                  child: Text('${c.symbol} ${c.code}'),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    ),
  );
}

  static String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
