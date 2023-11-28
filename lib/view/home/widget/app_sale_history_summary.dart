import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/model/sale.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_card_square.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';

class AppHistorySaleSummary extends StatelessWidget {
  final List<Sale> data;
  final Function() onSeeAll;
  const AppHistorySaleSummary({
    super.key,
    required this.onSeeAll,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onSeeAll,
          child: Container(
            color: Colors.transparent,
            margin: const EdgeInsets.only(bottom: 18),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Riwayat Penjualan",
                  style: TextStyle(fontSize: 16),
                ),
                AppSvgIcon(
                  svg: svgChevronRight,
                  size: 24,
                  color: AppTheme.capColor,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: data.isEmpty ? dataNotFound() : listHistory(),
        ),
      ],
    );
  }

  Widget listHistory() {
    return Column(
      children: [
        ...data.map(
          (e) => card(sale: e, isLast: e.id == data.last.id),
        ),
      ],
    );
  }

  Widget dataNotFound() => Column(
        children: [
          Container(
            width: 120,
            height: 120,
            color: Colors.transparent,
            margin: const EdgeInsets.only(bottom: 12),
            child: SvgPicture.asset(ilusNoDataSummary),
          ),
          const Text("Belum ada transaksi"),
        ],
      );

  Widget card({required Sale sale, required bool isLast}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : AppTheme.borderColor,
          ),
        ),
      ),
      child: Row(
        children: [
          AppCardSquare(
            size: 48,
            margin: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(sale.getInitial(), style: AppTheme.nameInitialStyle),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                sale.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.titleColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              sale.total,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
