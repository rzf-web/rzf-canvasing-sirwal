import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/view/transaction/widget/app_transaction_card.dart';
import 'package:rzf_canvasing_sirwal/widget/app_data_not_found.dart';
import 'package:rzf_canvasing_sirwal/widget/app_loading.dart';
import 'package:rzf_canvasing_sirwal/widget/app_remove_overscroll.dart';
import 'package:rzf_canvasing_sirwal/widget/app_smart_refresh.dart';

///Widget[AppListTransaction] Untuk menampilkan data order dan transaksi dalam satu widget
///dimana masing masing class order dan transaksi harus memiliki List data map
///yang memiliki key ['id','initial','name','address','total'],
class AppListTransaction extends StatelessWidget {
  final bool isLoading;
  final List<Map<String, dynamic>> data;
  final RefreshController controller;
  final dynamic Function() onLoading;
  final dynamic Function() onRefresh;
  final bool noData;
  const AppListTransaction({
    super.key,
    required this.data,
    required this.onRefresh,
    required this.controller,
    required this.onLoading,
    required this.noData,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Stack(
      children: [
        if (data.isEmpty && !isLoading) const AppDataNotFound(),
        if (isLoading)
          const AppLoading()
        else
          AppRemoveOverscroll(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: AppSmartRefresh(
                onRefresh: () => onRefresh(),
                onLoading: () => onLoading(),
                controller: controller,
                noData: noData,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 20),
                    ...data.map(
                      (e) => AppTransactionCard(
                        isLast: data.last['id'] == e['id'],
                        initial: e['initial'],
                        date: e['date'],
                        name: e['name'],
                        address: e['address'],
                        total: e['total'],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
