import 'package:expense_tracker/models/cathegory.dart';
import 'package:expense_tracker/models/payment_method.dart';

class Expense {
  final String amount;
  final String description;
  final PaymentMethod paymentMethod;
  final Cathegory cathegory;
  final DateTime date;

  const Expense(this.amount, this.description, this.paymentMethod, this.cathegory, this.date);

}