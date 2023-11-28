import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/data/cashflow.data.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/services/shared/shared_pref.dart';

class HomeController extends GetxController {
  final menu = <Map<String, String>>[
    {'icon': svgQrcode, 'title': 'Produk', 'route': Routes.product},
    {'icon': svgOrder, 'title': 'Pembelian', 'route': Routes.buy},
    {'icon': svgShoppingCart, 'title': 'Penjualan', 'route': Routes.sale},
    {'icon': svgCashflow, 'title': 'Cash Flow', 'route': Routes.cashflow},
  ];
  var cashIn = 0.0.obs;
  var cashOut = 0.0.obs;
  var selisih = 0.0.obs;

  getReportData() async {
    var now = DateTime.now();
    var startDate = DateTime(now.year, now.month, 1);
    var endDate = DateTime(now.year, now.month + 1, 1);

    waitingDialog();
    var data = await CashFlowData().fetchApiDataReport(
      startDate: dateFormatAPI(startDate),
      endDate: dateFormatAPI(endDate),
    );
    Get.back();
    var summary = data['summary'];
    cashIn.value = double.tryParse(summary['pemasukan'] ?? "0") ?? 0;
    cashOut.value = double.tryParse(summary['pengeluaran'] ?? "0") ?? 0;
    selisih.value = double.tryParse(summary['selisih'] ?? "0") ?? 0;
  }

  onMenuTap(String route) {
    if (route != '') Get.toNamed(route, arguments: {'fromHome': true});
  }

  logout() async {
    await SharedPrefs.clear();
    Get.offAllNamed(Routes.login);
  }

  @override
  Future<void> onInit() async {
    await Future.delayed(const Duration(milliseconds: 100));
    getReportData();
    super.onInit();
  }
}
