import 'package:flutter/material.dart';
import 'package:get/get.dart';

var isMobile = true;
var isTablet = false;

getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

getDevice(BuildContext context) {
  if (getWidth(context) < 480) {
    isMobile = true;
    isTablet = false;
  } else {
    isMobile = false;
    isTablet = true;
  }
}

bool isPortrait() {
  return MediaQuery.of(Get.context!).orientation == Orientation.portrait;
}

bool isLandscape() {
  return MediaQuery.of(Get.context!).orientation == Orientation.landscape;
}
