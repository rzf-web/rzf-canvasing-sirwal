import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/interface/iname.dart';

class Supplier with IName {
  final String? id;
  final String name;
  final String address;
  final String phone;
  final String contact;
  final String rekening;

  Supplier({
    this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.contact,
    required this.rekening,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['supplier_id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      contact: json['contact'],
      rekening: json['rekening'],
    );
  }

  Map<String, dynamic> toJson(bool isEdit, {bool isToDB = false}) {
    return {
      "user_id": GlobalVar.userId,
      if (isEdit || isToDB) 'supplier_id': id!,
      "name": name,
      "address": address,
      "phone": phone,
      "contact": contact,
      "rekening": rekening,
    };
  }

  String getInitial() {
    return super.getInitialName(name);
  }
}
