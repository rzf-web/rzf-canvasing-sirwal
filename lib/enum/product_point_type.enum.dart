enum ProductPointType { nonPoint, productQty, totalTransaction, productPrice }

extension ProductPointTypeExtension on ProductPointType {
  bool get isProductQty => this == ProductPointType.productQty;
  bool get isTotalTransaction => this == ProductPointType.totalTransaction;
  bool get isProductPrice => this == ProductPointType.productPrice;

  String get name {
    switch (this) {
      case ProductPointType.productQty:
        return 'Jumlah Produk';
      case ProductPointType.totalTransaction:
        return 'Nominal Transaksi';
      case ProductPointType.productPrice:
        return 'Nominal Produk';
      default:
        return 'Non Point';
    }
  }

  static ProductPointType generatePointType(String jpoin) {
    switch (jpoin.toLowerCase()) {
      case 'jumlah produk':
        return ProductPointType.productQty;
      case 'nominal transaksi':
        return ProductPointType.totalTransaction;
      case 'nominal produk':
        return ProductPointType.productPrice;
      default:
        return ProductPointType.nonPoint;
    }
  }
}
