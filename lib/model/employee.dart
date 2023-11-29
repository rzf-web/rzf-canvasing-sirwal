import 'package:rzf_canvasing_sirwal/interface/iname.dart';

class Employee with IName {
  final String user;
  final bool point;
  final String idCabang;
  final String cabang;
  final String jkas;

  Employee({
    required this.user,
    required this.point,
    required this.idCabang,
    required this.cabang,
    required this.jkas,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      user: json['user'] ?? '',
      point: json['poin'] == 'true' ? true : false,
      idCabang: json['idcabang'] ?? '',
      cabang: json['cabang'] ?? '',
      jkas: json['jkas'] ?? '',
    );
  }
  String getInitial() => super.getInitialName(user);
}
