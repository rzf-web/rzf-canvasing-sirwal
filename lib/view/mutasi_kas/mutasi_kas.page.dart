import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/mutasi_kas/mutasi_kas.controller.dart';
import 'package:rzf_canvasing_sirwal/view/mutasi_kas/widget/app_mutasi_kas_card.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_data_not_found.dart';
import 'package:rzf_canvasing_sirwal/widget/app_date_report.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';

class MutasiKasPage extends GetView<MutasiKasController> {
  const MutasiKasPage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: AppCustomAppBar(
        showLeading: true,
        title: "Mutasi Akun",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AppDateReport(onSubmit: controller.pickDate),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.mutasiKasUpdatePage,
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => Stack(
          children: [
            if (controller.mutations().isEmpty && !controller.isLoading.value)
              const AppDataNotFound(),
            if (controller.isLoading.value)
              const AppLoading()
            else
              AppRemoveOverscroll(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: RefreshIndicator(
                    onRefresh: () => controller.getMutations(),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        const SizedBox(height: 20),
                        ...controller.mutations().map(
                              (e) => GestureDetector(
                                onTap: () => controller.mutasiKasUpdatePage(
                                  data: e,
                                ),
                                child: AppMutasiKasCard(
                                  data: e,
                                  isLast: controller.getLastData().id == e.id,
                                ),
                              ),
                            ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
