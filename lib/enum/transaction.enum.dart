enum TransactionType { sale, buy }

extension TransactionTypeExtension on TransactionType {
  bool get isBuy {
    return this == TransactionType.buy;
  }

  bool get isSale {
    return this == TransactionType.sale;
  }
}
