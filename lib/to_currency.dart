library to_currency;

/// Formats a number as currency.
///
/// The number is formatted using the [amount] argument and the other arguments
/// are used to customize the output. The [currency] argument is used to specify
/// the currency to use. The [separator] argument is used to specify the separator
/// to use between the currency and the amount. The [currencyPrefixed] argument
/// is used to specify if the currency should be prefixed to the amount. The
/// [decimalSeparator] argument is used to specify the separator to use between
/// the whole part and the decimal part of the number. The [decimalDigits]
/// argument is used to specify the number of decimal digits to show.
///
/// You can use the [toUSD] and [toCFA] functions to format a number as a
/// specific currency.
String toCurrency({
  double amount = 0,
  String currency = "F CFA",
  String separator = " ",
  bool currencyPrefixed = false,
  String decimalSeparator = ".",
  int decimalDigits = 0,
  // int roundRatio = 0,
}) {
  // Determine if the amount is negative.
  final isNegative = amount < 0;

  // Convert amount to a positive value if it is negative.
  final amountPositive = isNegative ? -amount : amount;

  // Format the amount with the specified number of decimal digits.
  final amountAsString = amountPositive.toStringAsFixed(decimalDigits);

  // Split the formatted amount into whole and decimal parts.
  final decimals = amountAsString.split(".");

  // Split the whole part into individual characters.
  final splitted = decimals[0].split("");

  // Reverse the whole part for easier processing of thousands separator.
  final reversed = splitted.reversed.toList();

  // Insert thousands separator every three digits.
  final spaced = List.generate(reversed.length, (i) {
    final char = reversed[i];
    if (i == 0 || i == reversed.length - 1) return char;
    return (i + 1) % 3 == 0 ? "$separator$char" : char;
  });

  // Reverse back to original order and join the characters.
  final ordered = spaced.reversed.toList();
  final joined = ordered.join("") +
      (decimals.length > 1 ? "$decimalSeparator${decimals[1]}" : "");

  // Construct the final formatted currency string.
  final newAmount = "${isNegative ? (currencyPrefixed ? "" : "-") : ""}$joined";

  // Return the final formatted string with currency position based on preference.
  return currencyPrefixed
      ? "${isNegative ? "-" : ""}$currency $newAmount"
      : "$newAmount $currency";
}

/// Formats a number as USD.
String toUSD(double amount) {
  return toCurrency(
    amount: amount,
    currency: "USD",
  );
}

/// Formats a number as CFA.
String toCFA(double amount) {
  return toCurrency(amount: amount);
}

/// Formats a number as a dollar.
///
/// This function is similar to [toCurrency] but it formats the number as a
/// dollar and uses "." as the separator between the currency and the amount
/// and "," as the separator between the whole part and the decimal part of the
/// number.
String toDollar(double amount, {int decimalDigits = 0}) {
  return toCurrency(
    amount: amount,
    currency: "\$",
    currencyPrefixed: true,
    separator: ".",
    decimalSeparator: ",",
    decimalDigits: decimalDigits,
  );
}
