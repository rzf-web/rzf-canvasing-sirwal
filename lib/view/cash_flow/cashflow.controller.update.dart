import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:rzf_canvasing_sirwal/enum/cashflow.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/cashflow.dart';
import 'package:rzf_canvasing_sirwal/model/tsx_account.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_helper.dart';
import 'package:rzf_canvasing_sirwal/services/api/api_service.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';

class CashFlowUpdateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final data = Get.arguments;

  var date = DateTime.now();
  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final accountController = TextEditingController();
  final categoryController = TextEditingController();
  final noteController = TextEditingController();
  final jumlahController = TextEditingController();
  var jumlah = 0.0;
  var canSave = true.obs;
  var fromHome = false;
  CashFlowUpdateController({this.fromHome = false});

  onSave() async {
    if (data == null || data is! CashFlow) {
      _addCash();
    } else {
      _updateCash();
    }
  }

  _addCash() async {
    if (formKey.currentState!.validate()) {
      waitingDialog();
      var response = await ApiService.post(
        "$url$cashFlowUrl",
        data: _json(false),
      );
      Get.back();
      var success = await manageResponse(response);
      if (success) {
        if (!fromHome) {
          Get.back(result: true);
        } else {
          Get.back();
          Get.toNamed(Routes.cashflow);
        }
        manageResponse(response, success: true);
      }
    }
  }

  _updateCash() async {
    if (_getPrefixId() == "KS") {
      if (formKey.currentState!.validate()) {
        waitingDialog();
        var response = await ApiService.put(
          "$url$cashFlowUrl",
          data: _json(true),
        );
        Get.back();
        var success = await manageResponse(response);
        if (success) {
          Get.back(result: true);
          manageResponse(response, success: true);
        }
      }
    } else {
      showDialogAction(
        ActionDialog.warning,
        "Tidak bisa diubah karena terkait data lain",
      );
    }
  }

  String _getPrefixId() {
    var id = (data as CashFlow).id!.split('');
    var prefix = id[0] + id[1];
    return prefix;
  }

  Map<String, dynamic> _json(bool isEdit) {
    return {
      'user_id': GlobalVar.userId,
      if (isEdit) 'cash_id': (data as CashFlow).id,
      'cash_date': dateFormatAPI(date),
      'type': tabController.index == 0 ? 'Pemasukan' : 'Pengeluaran',
      'category': categoryController.text,
      'cash': jumlah.toInt(),
      'note': noteController.text,
      // 'account': accountController.text,
    };
  }

  pickDate() {
    showCustomDatePicker((date) {
      this.date = date;
      dateController.text = dateFormatUI(this.date);
    });
  }

  pickAccount() async {
    var data = await Get.toNamed(Routes.tsxAccount);
    if (data != null) {
      var account = data as TsxAccount;
      accountController.text = account.name;
    }
  }

  pickCategory() async {
    var data = await Get.toNamed(
      Routes.cashflowCategory,
      arguments:
          tabController.index == 0 ? CashFlowType.cashin : CashFlowType.cashout,
    );
    if (data != null) {
      categoryController.text = data;
    }
  }

  onCurrencyChanged(double v) {
    jumlah = v;
  }

  _initialize() {
    dateController.text = dateFormatUI(date);
    if (data != null && data is CashFlow) {
      var cashFlow = data as CashFlow;
      tabController.animateTo(cashFlow.type.isCashIn ? 0 : 1);
      date = cashFlow.date;
      jumlah = cashFlow.type.isCashIn ? cashFlow.cashin : cashFlow.cashout;
      dateController.text = dateFormatUI(date);
      accountController.text = cashFlow.account ?? '';
      categoryController.text = cashFlow.category;
      noteController.text = cashFlow.note;
      jumlahController.text = moneyFormatter(jumlah);
    }
    if (data != null && data is Map<String, dynamic>) {
      fromHome = data['fromHome'];
    }
    tabController.addListener(() {
      if (data != null && data is CashFlow) {
        var cashFlow = data as CashFlow;
        var cashType = cashFlow.type.isCashIn ? 0 : 1;
        var index = tabController.index;
        categoryController.text = cashType == index ? cashFlow.category : '';
      } else {
        categoryController.clear();
      }
    });
  }

  @override
  Future<void> onInit() async {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    _initialize();
    super.onInit();
  }
}
