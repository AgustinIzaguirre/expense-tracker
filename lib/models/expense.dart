import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/payment_method.dart';

class Expense {
  final String amount;
  final String description;
  final PaymentMethod paymentMethod;
  final Category category;
  final DateTime date;
  final String currency;

  const Expense(this.amount, this.description, this.paymentMethod, this.category, this.date, this.currency);

}