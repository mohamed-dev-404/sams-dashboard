//* Private reusable dropdown widget for this file
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';

class CustomDropdownField<T> extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    this.value,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  final T? value;
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      value: value,
      hint: Text(
        hintText,
        style: AppStyles.mobileLabelMediumRg.copyWith(
          color: AppColors.whiteDarkHover,
        ),
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: AppColors.secondary),
        ),
      ),
      items: items,
      onChanged: onChanged,
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.whiteDarkHover,
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondaryLightActive,
          ),
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.secondaryLight,
        ),
        //? Positioning the menu overlay relative to the field
        offset: const Offset(0, -6),
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 48.h,
      ),
      validator: validator,
    );
  }
}
