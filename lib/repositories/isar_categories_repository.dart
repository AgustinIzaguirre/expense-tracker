import 'package:expense_tracker/daos/category.dart';
import 'package:expense_tracker/infraestructure/isar_instance.dart';
import 'package:isar/isar.dart';


class IsarCategoriesRepository {
  Future<int> create(Category category) async {
    final isar = IsarInstance.isar;

    return isar.writeTxn(() async {
      return isar.categorys.put(category);
    });
  }

  Future<List<Category>> getAll() {
    final isar = IsarInstance.isar;
    return isar.categorys.where().sortByName().findAll();
  }
}
