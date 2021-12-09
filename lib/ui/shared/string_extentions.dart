class StringExtensions {
  static toDouble(String initialPrice) {
    if (initialPrice.isEmpty) return null;
    var result = initialPrice.replaceAll(('\$'), '');
    var finalPrice = double.parse('$result');
    return finalPrice;
  }
}
