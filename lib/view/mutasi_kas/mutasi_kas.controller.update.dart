import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/data/tsx_account.data.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/mutasi_kas.dart';
import 'package:rzf_canvasing_sirwal/model/tsx_account.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class MutasiKasUpdateController extends GetxController {
  final data = Get.arguments as MutasiKas?;
  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final sourceController = TextEditingController();
  final destinationController = TextEditingController();
  final nominalController = TextEditingController();
  final noteController = TextEditingController();
  var source = Rx<TsxAccount?>(null);
  var destination = Rx<TsxAccount?>(null);
  var date = DateTime.now();
  var nominal = 0.0.obs;

  onSave() {
    if (formKey.currentState!.validate()) {
      var nominalValid = _nominalValidation();
      if (nominalValid) {
        if (data == null) {
          _addMutation();
        } else {
          _updateMutation();
        }
      }
    }
  }

  _addMutation() async {
    waitingDialog();
    var response = await ApiService.post(
      "$url$mutasiCash",
      data: {
        "user_id": GlobalVar.userId,
        "mutation_date": dateFormatAPI(date),
        "account_source": source.value!.name,
        "account_destination": destination.value!.name,
        "nominal_mutation": nominal.value.toInt(),
        "note": noteController.text,
      },
    );
    Get.back();
    var succes = await manageResponse(response);
    if (succes) {
      Get.back(result: true);
      manageResponse(response, success: true);
    }
  }

  _updateMutation() async {
    waitingDialog();
    var response = await ApiService.put(
      "$url$mutasiCash",
      data: {
        "user_id": GlobalVar.userId,
        "mutation_id": data!.id,
        "mutation_date": dateFormatAPI(date),
        "account_source": source.value!.name,
        "account_destination": destination.value!.name,
        "nominal_mutation": nominal.value.toInt(),
        "note": noteController.text,
      },
    );
    Get.back();
    var succes = await manageResponse(response);
    if (succes) {
      Get.back(result: true);
      manageResponse(response, success: true);
    }
  }

  _getSource() async {
    var result = await TsxAccountData().getSingleAccounts(
      keyword: data!.source,
    );
    source.value = result;
  }

  _getDestination() async {
    var result = await TsxAccountData().getSingleAccounts(
      keyword: data!.destination,
    );
    destination.value = result;
  }

  onDeleteMutation() async {
    showDialogAction(
      ActionDialog.confirm,
      "Anda yakin ingin menghapus data tersebut?",
      onConfrimYes: () async {
        Get.back();
        waitingDialog();
        var response = await ApiService.delete(
          "$url$mutasiCash",
          data: getParamQuery(query: {"mutation_id": data!.id!}),
        );
        Get.back();
        var success = await manageResponse(response);
        if (success) {
          Get.back(result: true);
          manageResponse(response, success: true);
        }
      },
    );
  }

  pickDate() {
    showCustomDatePicker((date) {
      this.date = date;
      dateController.text = dateFormatUI(this.date);
    });
  }

  pickAccount(bool isSource) async {
    var data = await Get.toNamed(Routes.tsxAccount);
    if (data != null) {
      var account = data as TsxAccount;
      if (isSource) {
        source.value = account;
        sourceController.text = source.value!.name;
      } else {
        destination.value = account;
        destinationController.text = destination.value!.name;
      }
    }
  }

  onCurrencyChanged(double v) {
    nominal.value = v;
  }

  bool _nominalValidation() {
    if (nominal.value > source.value!.saldo) {
      showDialogAction(ActionDialog.warning, "Saldo sumber kurang!!!");
      return false;
    }
    return true;
  }

  _initialize() async {
    dateController.text = dateFormatUI(date);

    if (data != null) {
      await Future.delayed(const Duration(milliseconds: 100));
      waitingDialog();
      date = data!.date;
      nominal.value = data!.nominal;
      dateController.text = dateFormatUI(date);
      sourceController.text = data!.source;
      destinationController.text = data!.destination;
      destinationController.text = data!.destination;
      nominalController.text = moneyFormatter(nominal.value);
      noteController.text = data!.note;
      await _getSource();
      await _getDestination();
      Get.back();
    }
  }

  @override
  void onInit() {
    _initialize();
    super.onInit();
  }
}
