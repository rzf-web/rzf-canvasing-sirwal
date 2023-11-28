import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/helper/formatter.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _ChartData {
  final String name;
  final int value;
  final Color color;
  _ChartData(this.name, this.value, this.color);
}

class AppProductChartSummary extends StatefulWidget {
  final int sold;
  final List<Map<String, dynamic>> data;
  const AppProductChartSummary({
    super.key,
    required this.sold,
    required this.data,
  });

  @override
  State<AppProductChartSummary> createState() => _AppProductChartSummaryState();
}

class _AppProductChartSummaryState extends State<AppProductChartSummary> {
  var data = <_ChartData>[];

  initialize() {
    data.clear();
    for (var item in widget.data) {
      data.add(_ChartData(item['name'], item['percentage'], item['color']));
    }
  }

  @override
  Widget build(BuildContext context) {
    initialize();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: widget.data.isNotEmpty ? summary() : dataNotFound(),
    );
  }

  Widget summary() => Column(
        children: [
          summaryChart(),
          Container(
            height: 1,
            width: double.infinity,
            color: AppTheme.borderColor,
            margin: const EdgeInsets.all(20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...data.map(
                    (e) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: e.color,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        "${e.value}% ${e.name}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );

  Widget summaryChart() => Padding(
        padding: const EdgeInsets.only(left: 20, right: 10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      "Produk Terlaris",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.titleColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      dateFormatUI(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.capColor,
                      ),
                    ),
                  ),
                  Text(
                    "${numberFormatter(widget.sold.toDouble())} Total Produk Terjual",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.titleColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: chart(data),
              ),
            ),
          ],
        ),
      );

  Widget chart(List<_ChartData> chartData) => Container(
        width: 90,
        height: 90,
        color: Colors.transparent,
        padding: EdgeInsets.zero,
        child: SfCircularChart(
          margin: const EdgeInsets.all(0),
          tooltipBehavior: TooltipBehavior(
            enable: true,
          ),
          series: <CircularSeries>[
            DoughnutSeries<_ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (_ChartData data, _) => data.color,
              xValueMapper: (_ChartData data, _) => data.name,
              yValueMapper: (_ChartData data, _) => data.value,
              innerRadius: '60%',
            )
          ],
        ),
      );

  Widget dataNotFound() => Column(
        children: [
          Container(
            width: 144,
            height: 96,
            color: Colors.transparent,
            margin: const EdgeInsets.only(bottom: 12),
            child: SvgPicture.asset(ilusNoChart),
          ),
          const Text("Belum ada transaksi"),
        ],
      );
}
