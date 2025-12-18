import 'package:expense_tracker/models/group_by.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final DateTimeRange range;
  final GroupBy groupBy;
  final VoidCallback onPickRange;
  final ValueChanged<GroupBy> onChangeGroupBy;

  const HomeHeader({
    super.key,
    required this.range,
    required this.groupBy,
    required this.onPickRange,
    required this.onChangeGroupBy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onPickRange,
              icon: const Icon(Icons.date_range),
              label: Text('${_fmt(range.start)} - ${_fmt(range.end)}'),
            ),
          ),
          const SizedBox(width: 12),
          SegmentedButton<GroupBy>(
            segments: const [
              ButtonSegment(
                value: GroupBy.category,
                label: Text('Categorías'),
                icon: Icon(Icons.pie_chart),
              ),
              ButtonSegment(
                value: GroupBy.paymentMethod,
                label: Text('Pago'),
                icon: Icon(Icons.credit_card),
              ),
            ],
            selected: {groupBy},
            onSelectionChanged: (s) => onChangeGroupBy(s.first),
          ),
        ],
      ),
    );
  }

  static String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
