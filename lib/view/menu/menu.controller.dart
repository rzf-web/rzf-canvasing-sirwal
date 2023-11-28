import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/routes/app_pages.dart';
import 'package:rzf_canvasing_sirwal/services/shared/shared_pref.dart';

class AppMenuController extends GetxController {
  var delay = const Duration(milliseconds: 0);
  final menuMaster = <Map<String, dynamic>>[
    {
      'icon': svgMultipeUser,
      'title': 'Data Supplier',
      'route': Routes.supplier
    },
    {'icon': svgPeople, 'title': 'Data Pelanggan', 'route': Routes.customer},
    {'icon': svgQrcode, 'title': 'Produk', 'route': Routes.product},
    {'icon': svgShoppingCart, 'title': 'Penjualan', 'route': Routes.sale},
    {'icon': svgOrder, 'title': 'Pembelian', 'route': Routes.buy},
    {'icon': svgCashflow, 'title': 'Cash Flow', 'route': Routes.cashflow},
    {'icon': svgRetur, 'title': 'Mutasi Kas', 'route': Routes.mutasiKas},
  ];

  Duration getDelay() {
    var delay = this.delay;
    this.delay += const Duration(milliseconds: 50);
    return delay;
  }

  onMenuTap(String route) => Get.toNamed(route);

  resetDelay() {
    delay = const Duration(milliseconds: 100);
  }

  logout() async {
    await SharedPrefs.clear();
    Get.offAllNamed(Routes.login);
  }
}
