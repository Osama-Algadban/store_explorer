class PriceUtils {

  static double calculatePriceAfterDiscount(double price, double discountPercentage) {
    if (discountPercentage <= 0) return price;
    final discountAmount = price * (discountPercentage / 100);
    return price - discountAmount;
  }

  static double calculateSavedAmount(double price, double discountPercentage) {
    if (discountPercentage <= 0) return 0;
    return price * (discountPercentage / 100);
  }
}