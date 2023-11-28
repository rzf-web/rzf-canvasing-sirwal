import 'package:rzf_canvasing_sirwal/enum/cashflow.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/method.dart';

class CashFlowUI {
  final String header;
  final double total;
  final List<CashFlow> data;

  CashFlowUI({
    required this.header,
    required this.total,
    required this.data,
  });

  factory CashFlowUI.fromJson(Map<String, dynamic> json) {
    return CashFlowUI(
      header: json['date'],
      total: FuncHelper().jsonStringToDouble(json['total']),
      data: _generateData(json['detail']),
    );
  }

  static List<CashFlow> _generateData(dynamic json) {
    var data = <CashFlow>[];
    for (var item in json) {
      data.add(CashFlow.fromJson(item));
    }
    return data;
  }
}

class CashFlowReport {
  final String category;
  final String periode;
  final double total;

  CashFlowReport({
    required this.category,
    required this.periode,
    required this.total,
  });

  factory CashFlowReport.fromJson(Map<String, dynamic> json) {
    return CashFlowReport(
      category: json['category'] ?? '',
      periode: json['periode'] ?? '',
      total: double.tryParse(json['total']) ?? 0,
    );
  }
}

class CashFlow {
  final String? id;
  final DateTime date;
  final CashFlowType type;
  final String? account;
  final String category;
  final String note;
  final double cashin;
  final double cashout;

  CashFlow({
    this.id,
    required this.date,
    required this.type,
    required this.account,
    required this.category,
    required this.note,
    required this.cashin,
    required this.cashout,
  });

  factory CashFlow.fromJson(Map<String, dynamic> json) {
    return CashFlow(
      id: json['idkas'],
      date: DateTime.parse(json['tanggal'].toString()),
      type: _generateType(json['jenis']),
      category: json['kategori'],
      account: json['jkas'] ?? '',
      note: json['keterangan'] ?? '',
      cashin: FuncHelper().jsonStringToDouble(json['masuk']),
      cashout: FuncHelper().jsonStringToDouble(json['keluar']),
    );
  }

  static CashFlowType _generateType(dynamic json) {
    var type = json as String;
    if (type.toLowerCase() == CashFlowType.cashin.nameLocale.toLowerCase()) {
      return CashFlowType.cashin;
    } else {
      return CashFlowType.cashout;
    }
  }
}
