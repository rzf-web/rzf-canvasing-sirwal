import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/product/product/product.controller.detail.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_multi_unit/product.controller.detail_multi_unit.dart';
import 'package:rzf_canvasing_sirwal/view/product/satuan/satuan.controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
    Get.lazyPut<UnitController>(() => UnitController(), fenix: true);
    Get.lazyPut<ProductMultiUnitController>(
      () => ProductMultiUnitController(),
      fenix: true,
    );
  }
}
