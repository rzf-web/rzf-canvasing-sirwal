import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppBtmModalCameraSource extends StatelessWidget {
  final Function(ImageSource) onTap;
  const AppBtmModalCameraSource({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var sources = <Map<String, dynamic>>[
      {
        'icon': svgCamera,
        'title': 'Camera',
        'source': ImageSource.camera,
      },
      {
        'icon': svgGallery,
        'title': 'Galery',
        'source': ImageSource.gallery,
      },
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: sources
              .map(
                (e) => ListTile(
                  leading: AppSvgIcon(svg: e['icon']!, size: 24),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: Text(e['title']!),
                  horizontalTitleGap: 0,
                  onTap: () {
                    onTap(e['source']!);
                    Get.back();
                  },
                ),
              )
              .toList()),
    );
  }
}
