# to_currency

## Install the to_currency package from pub.dev:

```bash
flutter pub add to_currency
```

## Getting Started

```dart
import 'package:to_currency/to_currency.dart';

String amount = toCurrency(
    amount: 1000000,
    currency: "XOF",
    currencyPrefixed: false,
    separator: ".",
    decimalSeparator: ",",
    decimalDigits: 2,
);

print(amount); // 1.000.000,00 XOF

String cfa = toCFA(2000) // 2 000 F CFA

String dollar = toDollar(50.5, decimalDigits: 2); // $50.50

String usd = toUSD(-70.35); // -70.35 USD

```
