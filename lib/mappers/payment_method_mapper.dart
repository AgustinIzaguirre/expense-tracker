import 'package:expense_tracker/daos/payment_method.dart' as dao;
import 'package:expense_tracker/models/payment_method.dart' as model;

extension PaymentMethodDaoToModel on dao.PaymentMethod {
  model.PaymentMethod toModel() {
    return model.PaymentMethod(
      id: id,
      name: name,
      iconCodePoint: iconCodePoint,
      iconFontFamily: iconFontFamily,
    );
  }
}

extension PaymentMethodModelToDao on model.PaymentMethod {
  dao.PaymentMethod toDao() {
    return dao.PaymentMethod()
      ..id = id
      ..name = name
      ..iconCodePoint = iconCodePoint
      ..iconFontFamily = iconFontFamily;
  }
}
