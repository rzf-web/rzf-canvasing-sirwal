import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rzf_canvasing_sirwal/enum/transaction.enum.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/payment/payment.controller.dart';
import 'package:rzf_canvasing_sirwal/widget/app_button.dart';

class PaySuccessPage extends GetView<PaymentController> {
  const PaySuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    var total = controller.pay - controller.grandTotal;
    return WillPopScope(
      onWillPop: () async {
        controller.close();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(padding),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 48.0),
                        child: SvgPicture.asset(ilusPaySucces),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "Transaksi Berhasil",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.titleColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: controller.isPass()
                              ? 'Lunas'
                              : controller.isTunai()
                                  ? "Kembali "
                                  : "${controller.type.isBuy ? "Utang" : "Piutang "} ",
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppTheme.titleColor,
                          ),
                          children: [
                            TextSpan(
                              text: controller.isPass()
                                  ? ''
                                  : moneyFormatter(controller.isTunai()
                                      ? total
                                      : total * -1),
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Dibayar ${controller.paymentType.value}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppTheme.titleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                AppButton(
                  onPressed: controller.close,
                  child: const Text("Tutup", style: AppTheme.btnStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
