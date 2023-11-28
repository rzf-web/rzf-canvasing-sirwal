import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rzf_canvasing_sirwal/helper/assets.dart';
import 'package:rzf_canvasing_sirwal/theme/theme.dart';
import 'package:rzf_canvasing_sirwal/widget/app_svg_icon.dart';
import 'package:searchfield/searchfield.dart';

class AppDropDownSearch extends StatelessWidget {
  final String label;
  final String hintText;
  final double itemHeight;
  final List<dynamic>? data;
  final Widget? suffixIcon;
  final int maxSuggestionsInViewPort;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<SearchFieldListItem<dynamic>>? suggestions;
  final Function(SearchFieldListItem<dynamic>)? onSuggestionTap;
  final bool isLoading;
  const AppDropDownSearch({
    super.key,
    required this.label,
    required this.hintText,
    this.data,
    this.validator,
    this.controller,
    this.suggestions,
    this.suffixIcon,
    this.itemHeight = 50,
    this.onSuggestionTap,
    this.maxSuggestionsInViewPort = 4,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.titleColor,
            ),
          ),
        ),
        SearchField<dynamic>(
          enabled: !isLoading,
          validator: validator,
          controller: controller,
          textInputAction: TextInputAction.done,
          searchInputDecoration: AppTheme.textFieldInputDecoration.copyWith(
            hintText: hintText,
            suffixIcon: suffixIconDefault(),
          ),
          suggestionsDecoration: SuggestionDecoration(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(4),
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 12,
                color: AppTheme.shadowColor,
                offset: Offset(0, 1),
              )
            ],
          ),
          itemHeight: itemHeight,
          onSuggestionTap: onSuggestionTap,
          maxSuggestionsInViewPort: maxSuggestionsInViewPort,
          suggestionItemDecoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppTheme.borderColor)),
          ),
          suggestions: suggestions ??
              [...(data ?? []).map((e) => SearchFieldListItem(e))],
        ),
      ],
    );
  }

  Widget suffixIconDefault() => SizedBox(
        width: 10,
        height: 10,
        child: Stack(
          children: [
            if (isLoading)
              const Center(
                child: SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              Center(
                child: suffixIcon ??
                    Transform.rotate(
                      angle: pi / 2,
                      child: const AppSvgIcon(
                        svg: svgChevronRight,
                        size: 24,
                        color: AppTheme.capColor,
                      ),
                    ),
              ),
          ],
        ),
      );
}
