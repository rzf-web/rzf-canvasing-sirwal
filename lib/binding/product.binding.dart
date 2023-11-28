import 'package:get/instance_manager.dart';
import 'package:rzf_canvasing_sirwal/view/product/product/product.controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
