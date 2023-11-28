import 'package:rzf_canvasing_sirwal/helper/method.dart';

class TsxAccount {
  final String id;
  final String name;
  final double saldo;

  TsxAccount({
    required this.id,
    required this.name,
    required this.saldo,
  });

  factory TsxAccount.fromJson(Map<String, dynamic> json) {
    return TsxAccount(
      id: json['account_id'],
      name: json['account'],
      saldo: FuncHelper().jsonStringToDouble(json['saldo_kas']),
    );
  }
}
