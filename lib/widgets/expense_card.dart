import 'package:expense_tracker/models/Expense.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      Expense expense = Expense("\$100", "Burger King", "Visa Credito", "Rappi",  "1/1/2025");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(expense.amount, 
         style: TextStyle(
          fontSize: 14.0, // Makes the text bigger (adjust the value as needed)
          fontWeight: FontWeight.bold, // Makes the text bold
          ),
        ),
        Text(expense.description,
         style: TextStyle(
          fontSize: 14.0, // Makes the text bigger (adjust the value as needed)
          fontWeight: FontWeight.bold, // Makes the text bold
          ),),
        Text(expense.paymentMethod,
         style: TextStyle(
          fontSize: 14.0, // Makes the text bigger (adjust the value as needed)
          fontWeight: FontWeight.bold, // Makes the text bold
          ),),
        Text(expense.cathegory,
         style: TextStyle(
          fontSize: 14.0, // Makes the text bigger (adjust the value as needed)
          fontWeight: FontWeight.bold, // Makes the text bold
          ),),
        Text(expense.date,
         style: TextStyle(
          fontSize: 14.0, // Makes the text bigger (adjust the value as needed)
          fontWeight: FontWeight.bold, // Makes the text bold
          ),),
      ]
      );
  }
}