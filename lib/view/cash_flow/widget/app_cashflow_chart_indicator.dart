import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';

class AppCashFlowIndicator extends StatefulWidget {
  final double percent;
  const AppCashFlowIndicator({super.key, required this.percent});

  @override
  State<AppCashFlowIndicator> createState() => _AppCashFlowIndicatorState();
}

class _AppCashFlowIndicatorState extends State<AppCashFlowIndicator> {
  var toChart = 0.0;

  changeToChart() {
    toChart = widget.percent / 100;
    if (toChart > 1.0) {
      toChart = 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    changeToChart();
    return CircularPercentIndicator(
      animation: true,
      animationDuration: 800,
      percent: toChart,
      radius: 75.0,
      lineWidth: 20.0,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              "${(widget.percent).toInt()} %",
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Text(
            "Pengeluaran",
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.capColor,
            ),
          ),
        ],
      ),
      backgroundColor: AppTheme.secBgColor,
      progressColor: AppTheme.primaryColor,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
