import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/cashflow.data.dart';
import 'package:rzf_canvasing_sirwal/enum/cashflow.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/model/cashflow.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';

class CashFlowController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabControllerFilter;
  late TabController tabControllerReport;

  var isLoading = false.obs;
  var cashIn = <CashFlowUI>[].obs;
  var cashOut = <CashFlowUI>[].obs;
  var startDate = DateTime.now();
  var endDate = DateTime.now();
  var showAddBtn = true.obs;

  var reportSummaryIndex = 0.obs;
  var cashInSummary = 0.0.obs;
  var cashOutSummary = 0.0.obs;
  var selisihSummary = 0.0.obs;
  var percent = 0.0.obs;
  var cashInReport = <CashFlowReport>[].obs;
  var cashOutReport = <CashFlowReport>[].obs;
  var startDateReport = DateTime.now().obs;
  var endDateReport = DateTime.now().obs;

  getData() async {
    isLoading.value = true;
    cashIn.value = await CashFlowData().fetchApiData(
      type: CashFlowType.cashin,
      startDate: dateFormatAPI(startDate),
      endDate: dateFormatAPI(endDate),
    );
    cashOut.value = await CashFlowData().fetchApiData(
      type: CashFlowType.cashout,
      startDate: dateFormatAPI(startDate),
      endDate: dateFormatAPI(endDate),
    );
    isLoading.value = false;
  }

  getReportData() async {
    if (tabControllerFilter.index == 2) waitingDialog();
    var data = await CashFlowData().fetchApiDataReport(
      startDate: dateFormatAPI(startDateReport.value),
      endDate: dateFormatAPI(endDateReport.value),
    );
    if (tabControllerFilter.index == 2) Get.back();
    var summary = data['summary'];
    cashInSummary.value = double.tryParse(summary['pemasukan'] ?? "0") ?? 0;
    cashOutSummary.value = double.tryParse(summary['pengeluaran'] ?? "0") ?? 0;
    selisihSummary.value = double.tryParse(summary['selisih'] ?? "0") ?? 0;
    percent.value = double.tryParse(summary['persentasi'] ?? "0") ?? 0;

    cashInReport.clear();
    for (var item in data['cashIn']) {
      cashInReport.add(CashFlowReport.fromJson(item));
    }
    cashOutReport.clear();
    for (var item in data['cashOut']) {
      cashOutReport.add(CashFlowReport.fromJson(item));
    }
  }

  updateCashFlowPage({CashFlow? data}) async {
    var update = await Get.toNamed(Routes.cashflowUpdate, arguments: data);
    if (update != null) {
      await getData();
    }
  }

  pickDate(v1, v2) async {
    startDate = v1;
    endDate = v2;
    await getData();
  }

  changeDateReport(DateTime start, DateTime end) async {
    startDateReport.value = start;
    endDateReport.value = end;
    await getReportData();
  }

  _initialize() {
    _tabListenerFilter();
    _tabReportListener();
    getData();
    getReportData();
  }

  _tabListenerFilter() {
    tabControllerFilter.addListener(() {
      var index = tabControllerFilter.index;
      showAddBtn.value = index < 2;
    });
  }

  _tabReportListener() {
    tabControllerReport.addListener(() {
      var index = tabControllerReport.index;
      reportSummaryIndex.value = index;
    });
  }

  @override
  Future<void> onInit() async {
    tabControllerFilter = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    tabControllerReport = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    var now = DateTime.now();
    startDateReport.value = DateTime(now.year, now.month, 1);
    endDateReport.value = DateTime(now.year, now.month + 1, 1);
    _initialize();
    super.onInit();
  }
}
