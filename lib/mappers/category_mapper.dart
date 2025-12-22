import 'package:expense_tracker/daos/category.dart' as dao;
import 'package:expense_tracker/models/category.dart' as model;

extension CategoryDaoToModel on dao.Category {
  model.Category toModel() {
    return model.Category(
      id: id, // si en model usás int
      name: name,
      iconCodePoint: iconCodePoint,
      iconFontFamily: iconFontFamily,
    );
  }
}

extension CategoryModelToDao on model.Category {
  dao.Category toDao() {
    return dao.Category()
      ..id = id // si tu dao usa Id autoIncrement, podés omitir si es nuevo
      ..name = name
      ..iconCodePoint = iconCodePoint
      ..iconFontFamily = iconFontFamily;
  }
}
