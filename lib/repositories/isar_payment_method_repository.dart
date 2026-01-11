import 'package:expense_tracker/daos/payment_method.dart';
import 'package:expense_tracker/infraestructure/isar_instance.dart';
import 'package:isar/isar.dart';


class IsarPaymentMethodRepository {
  Future<int> create(PaymentMethod paymentMethod) async {
    final isar = IsarInstance.isar;

    return isar.writeTxn(() async {
      return isar.paymentMethods.put(paymentMethod);
    });
  }

  Future<List<PaymentMethod>> getAll() {
    final isar = IsarInstance.isar;
    return isar.paymentMethods.where().sortByName().findAll();
  }

  Future<void> deleteAll() async {
    final isar = IsarInstance.isar;

    await isar.writeTxn(() async {
      await isar.paymentMethods.clear(); // borra todo de la colección
    });
  }

  Future<bool> deleteById(int id) async {
    final isar = IsarInstance.isar;

    return isar.writeTxn(() async {
      return isar.paymentMethods.delete(id);
    });
  }

  Future<int> update(PaymentMethod paymentMethod) async {
    final isar = IsarInstance.isar;
    return isar.writeTxn(() async {
      return isar.paymentMethods.put(paymentMethod); // put = insert o update
    });
  }
}
