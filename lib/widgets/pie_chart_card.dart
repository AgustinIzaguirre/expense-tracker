import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'expenses_legend.dart';

const pieColors = [
  Color(0xFF4CAF50), // verde
  Color(0xFF2196F3), // azul
  Color(0xFFFFC107), // amarillo
  Color(0xFFF44336), // rojo
  Color(0xFF9C27B0), // violeta
  Color(0xFF009688), // teal
];

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
      for (int i = 0; i < displayed.length; i++)
        PieChartSectionData(
          value: displayed[i].value,
          title: '${_pct(displayed[i].value, totalAmount)}%',
          radius: 55,
          color: pieColors[i % pieColors.length],
          titleStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
        ),
      if (othersSum > 0)
        PieChartSectionData(
          value: othersSum,
          title: '${_pct(othersSum, totalAmount)}%',
          radius: 55,
          color: pieColors[displayed.length % pieColors.length],
          titleStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
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
