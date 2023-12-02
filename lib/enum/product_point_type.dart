enum ProductPointType { productQty, totalTransaction, productPrice }

extension ProductPointTypeExtension on ProductPointType {
  bool get isProductQty => this == ProductPointType.productQty;
  bool get isTotalTransaction => this == ProductPointType.totalTransaction;
  bool get isProductPrice => this == ProductPointType.productPrice;

  String get name {
    switch (this) {
      case ProductPointType.totalTransaction:
        return 'Nominal Transaksi';
      case ProductPointType.productPrice:
        return 'Nominal Produk';
      default:
        return 'Jumlah Produk';
    }
  }

  static ProductPointType generatePointType(String jpoin) {
    switch (jpoin.toLowerCase()) {
      case 'nominal transaksi':
        return ProductPointType.totalTransaction;
      case 'nominal produk':
        return ProductPointType.productPrice;
      default:
        return ProductPointType.productQty;
    }
  }
}
