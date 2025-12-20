import 'package:flutter/material.dart';

class PieChartLegend extends StatelessWidget {
  final List<MapEntry<String, double>> displayed;
  final double othersSum;
  final double total;

  const PieChartLegend({
    super.key,
    required this.displayed,
    required this.othersSum,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final items = <MapEntry<String, double>>[
      ...displayed,
      if (othersSum > 0) MapEntry('Otros', othersSum),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final e in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 10),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    e.key,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${total <= 0 ? 0 : ((e.value / total) * 100).round()}%',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
