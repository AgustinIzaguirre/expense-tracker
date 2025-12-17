import 'package:expense_tracker/models/Expense.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      Expense expense = Expense("100", "Burger King", "Visa Credito", "Rappi",  "1/1/2025");

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(expense.cathegory.characters.first.toUpperCase()),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    expense.description,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '\$${expense.amount}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text(expense.cathegory)),
                Chip(label: Text(expense.paymentMethod)),
                Chip(label: Text(expense.date)),
              ],
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}