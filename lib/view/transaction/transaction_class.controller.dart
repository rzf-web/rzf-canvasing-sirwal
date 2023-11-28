import 'package:rzf_canvasing_sirwal/model/product.onCart.dart';

abstract class TsxListController<T> {
  Future<T> getData();
  Future refreshData();
  Future loadData();
  void productListPage();
}

abstract class TsxAddController {
  void paymentPage(List<ProductOnCart> data);
}
