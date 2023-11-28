import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_drop_down_search.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';
import 'package:searchfield/searchfield.dart';

class AppPaymentDropDownSearch extends StatelessWidget {
  final String label;
  final String hint;
  final List<SearchFieldListItem<dynamic>> suggestions;
  final dynamic Function(SearchFieldListItem<dynamic>) onSuggestionTap;
  const AppPaymentDropDownSearch({
    super.key,
    required this.label,
    required this.hint,
    required this.onSuggestionTap,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropDownSearch(
      label: label,
      hintText: hint,
      itemHeight: 100,
      maxSuggestionsInViewPort: 4,
      onSuggestionTap: onSuggestionTap,
      suggestions: suggestions,
      suffixIcon: const AppSvgIcon(
        svg: svgSearch,
        size: 20,
        color: AppTheme.capColor,
      ),
    );
  }
}
