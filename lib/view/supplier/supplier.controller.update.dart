import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/model/supplier.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';

class SupplierUpdateController extends GetxController {
  var data = Get.arguments as Supplier?;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final contactController = TextEditingController();
  final rekController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  initializeData() {
    if (data != null) {
      nameController.text = data!.name;
      phoneController.text = data!.phone;
      contactController.text = data!.contact;
      rekController.text = data!.rekening;
      addressController.text = data!.address;
    }
  }

  onSave() {
    if (formKey.currentState!.validate()) {
      if (data != null) {
        updateSupplier();
      } else {
        addSupplier();
      }
    }
  }

  addSupplier() async {
    isLoading.value = true;
    var response = await ApiService.post(
      "$url$supplierUrl",
      data: _json(false),
    );
    isLoading.value = false;
    var success = await manageResponse(response);
    if (success) {
      Get.back(result: true);
      manageResponse(response, success: true);
    }
  }

  updateSupplier() async {
    isLoading.value = true;
    var response = await ApiService.put(
      "$url$supplierUrl",
      data: _json(true),
    );
    isLoading.value = false;
    var success = await manageResponse(response);
    if (success) {
      Get.back(result: data);
      manageResponse(response, success: true);
    }
  }

  _json(bool isEdit) {
    var data = Supplier(
      id: this.data?.id,
      name: nameController.text,
      address: addressController.text,
      phone: phoneController.text,
      contact: contactController.text,
      rekening: rekController.text,
    );
    if (this.data != null) this.data = data;
    return data.toJson(isEdit);
  }

  @override
  void onInit() {
    initializeData();
    super.onInit();
  }
}
