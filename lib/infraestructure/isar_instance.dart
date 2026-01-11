import 'package:expense_tracker/daos/category.dart';
import 'package:expense_tracker/daos/payment_method.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


class IsarInstance {
  static late final Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [CategorySchema, PaymentMethodSchema],
      directory: dir.path,
    );
  }
}
