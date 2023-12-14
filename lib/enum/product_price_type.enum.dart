enum ProductPriceType { retail, member, grosir3, grosir6, grosir12, agen }

extension ProductPriceTypeExtension on ProductPriceType {
  static ProductPriceType generateJson(String json) {
    switch (json.toLowerCase()) {
      case "retail":
        return ProductPriceType.retail;
      case "member":
        return ProductPriceType.member;
      case "grosir 3":
        return ProductPriceType.grosir3;
      case "grosir 6":
        return ProductPriceType.grosir6;
      case "grosir 12":
        return ProductPriceType.grosir12;
      case "agen":
        return ProductPriceType.agen;
      default:
        return ProductPriceType.retail;
    }
  }

  bool get isRetail => this == ProductPriceType.retail;
}
