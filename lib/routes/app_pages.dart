import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/binding/buy.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/buy_add.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/cashflow.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/cashflow_update.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/customer.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/customer_detail.binding..dart';
import 'package:rzf_canvasing_sirwal/binding/customer_update.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/home.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/mutasi_kas.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/mutasi_kas_update.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/navigation.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/payment.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/product.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/product_detail.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/product_update.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/sale.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/sale_add.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/scanner.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/signin.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/supplier.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/supplier_detail.binding.dart';
import 'package:rzf_canvasing_sirwal/binding/supplier_update.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.page.category.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.page.dart';
import 'package:rzf_canvasing_sirwal/view/cash_flow/cashflow.page.update.dart';
import 'package:rzf_canvasing_sirwal/view/customer/customer.page.dart';
import 'package:rzf_canvasing_sirwal/view/customer/customer.page.detail.dart';
import 'package:rzf_canvasing_sirwal/view/customer/customer.page.update.dart';
import 'package:rzf_canvasing_sirwal/view/home/home.page.dart';
import 'package:rzf_canvasing_sirwal/view/mutasi_kas/mutasi_kas.page.dart';
import 'package:rzf_canvasing_sirwal/view/mutasi_kas/mutasi_kas.page.update.dart';
import 'package:rzf_canvasing_sirwal/view/navigation/navigation.page.dart';

import 'package:rzf_canvasing_sirwal/view/product/product/product.page.dart';
import 'package:rzf_canvasing_sirwal/view/product/product/product.page.detail.dart';
import 'package:rzf_canvasing_sirwal/view/product/product/product.page.update.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_category/product.page.category.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_factory/product.page.factory.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_multi_unit/product.page.detail_multi_unit.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_rack/product.page.rack.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_type/product.page.type.dart';

import 'package:rzf_canvasing_sirwal/view/scanner/scanner.page.dart';
import 'package:rzf_canvasing_sirwal/view/signin/signin.page.dart';
import 'package:rzf_canvasing_sirwal/view/splash_screen/splash_screen.page.dart';
import 'package:rzf_canvasing_sirwal/view/supplier/supplier.page.dart';
import 'package:rzf_canvasing_sirwal/view/supplier/supplier.page.detail.dart';
import 'package:rzf_canvasing_sirwal/view/supplier/supplier.page.update.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/buy/buy.page.add.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/buy/buy.page.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/payment/payment.page.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/sale/sale.page.add.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/sale/sale.page.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/tsx_account/tsx_account.page.account.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const _pageTransition = Transition.fadeIn;
  static const intial = Routes.splashScreen;

  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreenPage(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.login,
      page: () => const SignInPage(),
      binding: SignInBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.navigation,
      page: () => const NavigationPage(),
      binding: NavigationBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.supplier,
      page: () => const SupplierPage(),
      binding: SupplierBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.supplierDetail,
      page: () => const SupplierDetailPage(),
      binding: SupplierDetailBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.supplierUpdate,
      page: () => const SupplierUpdatePage(),
      binding: SupplierUpdateBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.customer,
      page: () => const CustomerPage(),
      binding: CustomerBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.customerDetail,
      page: () => const CustomerDetailPage(),
      binding: CustomerDetailBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.customerUpdate,
      page: () => const CustomerUpdatePage(),
      binding: CustomerUpdateBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.sale,
      page: () => const SalePage(),
      binding: SaleBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.saleAdd,
      page: () => const SaleAddPage(),
      binding: SaleAddBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.buy,
      page: () => const BuyPage(),
      binding: BuyBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.buyAdd,
      page: () => const BuyAddPage(),
      binding: BuyAddBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.payment,
      page: () => const PaymentPage(),
      binding: PaymentBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.scannerView,
      page: () => const ScannerPage(),
      binding: ScannerBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.product,
      page: () => const ProductPage(),
      binding: ProductBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.productDetail,
      page: () => const ProductDetailPage(),
      binding: ProductDetailBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.productUpdate,
      page: () => const ProductUpdatePage(),
      binding: ProductUpdateBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.productCategory,
      page: () => const ProductCategoryPage(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.productRack,
      page: () => const ProductRackPage(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.productType,
      page: () => const ProductTypePage(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.productFactory,
      page: () => const ProductFactoryPage(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.productDetailMultiUnit,
      page: () => const ProductDetailMultiUnitPage(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.cashflow,
      page: () => const CashFlowPage(),
      binding: CashFlowBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.cashflowUpdate,
      page: () => const CashFlowUpdatePage(),
      binding: CashFlowUpdateBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.cashflowCategory,
      page: () => const CashFlowCategoryPage(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.tsxAccount,
      page: () => const TsxAccountPage(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.mutasiKas,
      page: () => const MutasiKasPage(),
      binding: MutasiKasBinding(),
      transition: _pageTransition,
    ),
    GetPage(
      name: Routes.mutasiKasUpdate,
      page: () => const MutasiKasUpdatePage(),
      binding: MutasiKasUpdateBinding(),
      transition: _pageTransition,
    ),
  ];
}
