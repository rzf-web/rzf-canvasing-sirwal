import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/interface/iname.dart';

class MutasiKas extends IName {
  final String? id;
  final DateTime date;
  final String source;
  final String destination;
  final double nominal;
  final String note;

  MutasiKas({
    this.id,
    required this.date,
    required this.source,
    required this.destination,
    required this.nominal,
    required this.note,
  });

  factory MutasiKas.fromJson(Map<String, dynamic> json) {
    return MutasiKas(
      id: json['mutation_id'],
      date: DateTime.parse(json['mutation_date']),
      source: json['account_source'],
      destination: json['account_destination'],
      nominal: FuncHelper().jsonStringToDouble(json['nominal_mutation']),
      note: json['note'],
    );
  }

  String getInitial() {
    return super.getInitialName(source);
  }
}
