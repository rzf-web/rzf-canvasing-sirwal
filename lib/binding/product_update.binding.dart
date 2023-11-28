import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/view/product/product/product.controller.update.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_category/product.controller.category.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_factory/product.controller.factory.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_rack/product.controller.rack.dart';
import 'package:rzf_canvasing_sirwal/view/product/product_type/product.controller.type.dart';
import 'package:rzf_canvasing_sirwal/view/product/satuan/satuan.controller.dart';

class ProductUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductUpdateController>(() => ProductUpdateController());
    Get.lazyPut<UnitController>(() => UnitController(), fenix: true);
    Get.lazyPut<ProductTypeController>(
      () => ProductTypeController(),
      fenix: true,
    );
    Get.lazyPut<ProductRackController>(
      () => ProductRackController(),
      fenix: true,
    );
    Get.lazyPut<ProductFactoryController>(
      () => ProductFactoryController(),
      fenix: true,
    );
    Get.lazyPut<ProductCategoryController>(
      () => ProductCategoryController(),
      fenix: true,
    );
  }
}
