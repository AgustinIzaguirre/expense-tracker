import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'expenses_legend.dart';

class PieChartCard extends StatelessWidget {
  final String title;
  final Map<String, double> totals;

  const PieChartCard({
    super.key,
    required this.title,
    required this.totals,
  });

  @override
  Widget build(BuildContext context) {
    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final totalAmount = totals.values.fold<double>(0, (a, b) => a + b);

    const maxSlices = 5;
    final displayed = entries.take(maxSlices).toList();
    final othersSum =
        entries.skip(maxSlices).fold<double>(0, (a, e) => a + e.value);

    final sections = <PieChartSectionData>[
      for (final e in displayed)
        PieChartSectionData(
          value: e.value,
          title: '${_pct(e.value, totalAmount)}%',
          radius: 55,
          titleStyle: Theme.of(context).textTheme.labelMedium,
        ),
      if (othersSum > 0)
        PieChartSectionData(
          value: othersSum,
          title: '${_pct(othersSum, totalAmount)}%',
          radius: 55,
          titleStyle: Theme.of(context).textTheme.labelMedium,
        ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sections: sections.isEmpty
                            ? [PieChartSectionData(value: 1, title: '0%')]
                            : sections,
                        centerSpaceRadius: 35,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 160,
                    child: ExpensesLegend(
                      displayed: displayed,
                      othersSum: othersSum,
                      total: totalAmount,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Total período: \$${totalAmount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  static int _pct(double value, double total) =>
      total <= 0 ? 0 : ((value / total) * 100).round();
}
