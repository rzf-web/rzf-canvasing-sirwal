import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/dialog.dart';
import 'package:rzf_canvasing_sirwal/services/printer/blue_thermal_printer.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_list.dart';
import 'package:rzf_canvasing_sirwal/widget/app_custom_appbar.dart';
import 'package:rzf_canvasing_sirwal/widget/app_data_not_found.dart';
import 'package:rzf_canvasing_sirwal/widget/app_dialog_action.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class PrinterPage extends StatefulWidget {
  const PrinterPage({super.key});

  static open() => Get.to(const PrinterPage());

  @override
  State<PrinterPage> createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  var isLoading = false.obs;
  var deviceConnected = Rx<BluetoothDevice?>(null);

  getDevice() async {
    isLoading.value = true;
    await Printer.getDevices();
    isLoading.value = false;
  }

  Future<void> refresh() async {
    await Printer.refresh();
  }

  connect(BluetoothDevice device) async {
    deviceConnected.value = await Printer.connect(device);
  }

  disconnect() {
    showDialogAction(
      ActionDialog.confirm,
      "Anda ingin memutus perangkat ?",
      onConfrimYes: () async {
        Get.back();
        await Printer.disconnect();
        deviceConnected.value = null;
      },
    );
  }

  @override
  void initState() {
    getDevice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      appBar: const AppCustomAppBar(title: "Setting Printer"),
      body: Obx(
        () => Stack(
          children: [
            if (Printer.devices.isEmpty && !isLoading.value)
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: AppDataNotFound(height: 150, width: 206),
              ),
            if (isLoading.value)
              const AppLoading()
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding),
                child: AppRemoveOverscroll(
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: SingleChildScrollView(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: padding),
                            if (deviceConnected.value != null)
                              const Padding(
                                padding: EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  "Perangkat Terhubung",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            if (deviceConnected.value != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: deviceConnectedCard(),
                              ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                "Perangkat Tersedia",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            deviceList(),
                            const SizedBox(height: padding),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget deviceConnectedCard() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(5, 12),
              color: Colors.black.withOpacity(.02),
            )
          ],
        ),
        child: Obx(
          () => GestureDetector(
            onTap: disconnect,
            child: AppCardList(
              isLast: true,
              marginPadding: 16,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: AppSvgIcon(svg: svgPrinter, size: 20),
                  ),
                  Text(deviceConnected.value?.name ?? ''),
                ],
              ),
            ),
          ),
        ),
      );

  Widget deviceList() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(5, 12),
              color: Colors.black.withOpacity(.02),
            )
          ],
        ),
        child: Column(
          children: Printer.devices.map((e) => deviceCard(e)).toList(),
        ),
      );

  Widget deviceCard(BluetoothDevice e) {
    var isLast = e.name == Printer.devices.last.name;
    return GestureDetector(
      onTap: () => connect(e),
      child: AppCardList(
        isLast: isLast,
        marginPadding: 16,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: AppSvgIcon(svg: svgPrinter, size: 20),
            ),
            Text(e.name ?? '')
          ],
        ),
      ),
    );
  }
}
