part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splashScreen = _Paths.splashScreen;
  static const login = _Paths.login;
  static const home = _Paths.home;
  static const navigation = _Paths.navigation;
  static const supplier = _Paths.supplier;
  static const supplierDetail = _Paths.supplierDetail;
  static const supplierUpdate = _Paths.supplierUpdate;
  static const customer = _Paths.customer;
  static const customerDetail = _Paths.customerDetail;
  static const customerUpdate = _Paths.customerUpdate;
  static const sale = _Paths.sale;
  static const saleAdd = _Paths.saleAdd;
  static const buy = _Paths.buy;
  static const buyAdd = _Paths.buyAdd;
  static const scannerView = _Paths.scannerView;
  static const product = _Paths.product;
  static const productDetail = _Paths.productDetail;
  static const productDetailMultiUnit = _Paths.productDetailMultiUnit;
  static const productUpdate = _Paths.productUpdate;
  static const productType = _Paths.productType;
  static const productCategory = _Paths.productCategory;
  static const productRack = _Paths.productRack;
  static const productFactory = _Paths.productFactory;
  static const payment = _Paths.payment;
  static const cashflow = _Paths.cashflow;
  static const cashflowUpdate = _Paths.cashflowUpdate;
  static const cashflowCategory = _Paths.cashflowCategory;
  static const tsxAccount = _Paths.tsxAccount;
  static const mutasiKas = _Paths.mutasiKas;
  static const mutasiKasUpdate = _Paths.mutasiKasUpdate;
}

abstract class _Paths {
  _Paths._();
  static const splashScreen = '/splash-screen';
  static const login = '/login';
  static const navigation = '/navigation';
  static const home = '/home';
  static const buy = '/buy';
  static const buyAdd = '/buy/add';
  static const sale = '/sale';
  static const saleAdd = '/sale/add';
  static const cashflow = '/cashflow';
  static const payment = '/payment';
  static const supplier = '/supplier';
  static const supplierDetail = '/supplier/detail';
  static const supplierUpdate = '/supplier/update';
  static const customer = '/customer';
  static const customerDetail = '/customer/detail';
  static const customerUpdate = '/customer/update';
  static const cashflowUpdate = '/cashflow/update';
  static const cashflowCategory = '/cashflow/category';
  static const tsxAccount = '/transaction-account';
  static const product = '/product';
  static const productDetail = '/product/detail';
  static const productUpdate = '/product/update';
  static const productCategory = '/product/category';
  static const scannerView = '/scanner';
  static const mutasiKas = '/mutasi-kas';
  static const mutasiKasUpdate = '/mutasi-kas/update';
  static const productType = '/product/type';
  static const productRack = '/product/rack';
  static const productFactory = '/product/factory';
  static const productDetailMultiUnit = '/product/detail/MultiUnit';
}
