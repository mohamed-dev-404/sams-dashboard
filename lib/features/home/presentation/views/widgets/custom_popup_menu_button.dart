import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';

/// Reusable popup menu button for enum-based filters
/// (e.g. Role, Status)
class CustomPopupMenuButton<T extends Enum> extends StatelessWidget {
  const CustomPopupMenuButton({
    super.key,
    required this.label,
    required this.items,
    required this.icon,
    required this.onSelected,
    required this.itemLabelBuilder,
    this.selectedValue,
  });

  /// Default button label
  final String label;

  /// SVG icon path
  final String icon;

  /// Enum values shown in the menu
  final List<T> items;

  /// Called when an item is selected
  final ValueChanged<T> onSelected;

  /// Converts enum value to display text
  final String Function(T item) itemLabelBuilder;

  /// Currently selected value (optional)
  final T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      // * Button container styling
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),

      child: PopupMenuButton<T>(
        // ? Emits selected enum value to parent widget
        onSelected: onSelected,

        // * Positions menu below the button
        offset: const Offset(0, 45),
        color: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.primaryLightHover),
        ),

        // * Build menu items from enum list
        itemBuilder: (_) => items
            .map(
              (item) => PopupMenuItem<T>(
                value: item,
                child: Text(
                  itemLabelBuilder(item),
                  style: AppStyles.mobileBodySmallMd.copyWith(
                    color: AppColors.primaryDarkHover,
                  ),
                ),
              ),
            )
            .toList(),

        // * Button content
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 8),
            Text(
              selectedValue != null
                  ? '$label: ${itemLabelBuilder(selectedValue!)}'
                  : label,
              style: AppStyles.mobileBodyXsmallRg.copyWith(
                color: AppColors.whiteDarkActive,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.whiteDarkActive,
            ),
          ],
        ),
      ),
    );
  }
}
