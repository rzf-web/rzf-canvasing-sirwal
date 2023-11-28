enum CashFlowType { cashin, cashout }

extension CashFlowTypeExtension on CashFlowType {
  String get nameLocale {
    if (this == CashFlowType.cashin) {
      return "Pemasukan";
    } else {
      return "Pengeluaran";
    }
  }

  bool get isCashIn => this == CashFlowType.cashin;
  bool get isCashOut => this == CashFlowType.cashout;
}
