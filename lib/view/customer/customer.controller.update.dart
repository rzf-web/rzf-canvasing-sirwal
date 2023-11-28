import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/model/customer.dart';

class CustomerUpdateController extends GetxController {
  final data = Get.arguments as Customer?;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final kabController = TextEditingController();
  final addressController = TextEditingController();
  final mapController = TextEditingController();
  final photoController = TextEditingController();

  final photos = <dio.MultipartFile>[].obs;
  final formKey = GlobalKey<FormState>();

  initializeData() {
    if (data != null) {}
  }

  onSave() {
    if (formKey.currentState!.validate()) {
      if (data != null) {
        updateCustomer();
      } else {
        addCustomer();
      }
    }
  }

  addCustomer() {}
  updateCustomer() {}
  onMapPick() {}

  onPickImage(BuildContext context) async {
    var source = await showImagePicker(context);
    if (source != null) {
      waitingDialog();
      final resultImg = await ImagePicker().pickImage(
        source: source,
        imageQuality: 60,
        maxHeight: 1000,
        maxWidth: 1000,
      );
      Get.back();
      if (resultImg != null) {
        var image = File(resultImg.path);
        String fileName = image.path.split('/').last;
        photos.add(await dio.MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ));
        photoController.text = "${photos.length} photo";
      }
    }
  }

  onClearPhoto() {
    photos.clear();
    photoController.text = "";
  }

  @override
  void onInit() {
    initializeData();
    super.onInit();
  }
}
