enum Currency {
  ars,
  usd,
  eur,
}

extension CurrencyX on Currency {
  String get code {
    switch (this) {
      case Currency.ars:
        return 'ARS';
      case Currency.usd:
        return 'USD';
      case Currency.eur:
        return 'EUR';
    }
  }

  String get symbol {
    switch (this) {
      case Currency.ars:
        return '\$';
      case Currency.usd:
        return 'US\$';
      case Currency.eur:
        return '€';
    }
  }
}
