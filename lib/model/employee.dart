import 'package:rzf_canvasing_sirwal/helper/method.dart';
import 'package:rzf_canvasing_sirwal/interface/iname.dart';

class Employee with IName {
  final String user;
  final double nominalPoint;
  final String idCabang;
  final String cabang;
  final String jkas;

  Employee({
    required this.user,
    required this.nominalPoint,
    required this.idCabang,
    required this.cabang,
    required this.jkas,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      user: json['user'] ?? '',
      nominalPoint: FuncHelper().jsonStringToDouble(json['poin']),
      idCabang: json['idcabang'] ?? '',
      cabang: json['cabang'] ?? '',
      jkas: json['jkas'] ?? '',
    );
  }
  String getInitial() => super.getInitialName(user);
}
