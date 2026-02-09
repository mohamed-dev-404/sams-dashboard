import 'package:flutter/material.dart';
import 'package:sams_dashboard/core/models/app_button_style_model.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.model});
  final AppButtonStyleModel model;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: model.width ?? double.infinity,
      height: model.height ?? 50,
      child: ElevatedButton(
        onPressed: model.onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15),
          ),
          elevation: 4,
          backgroundColor: model.backgroundColor,
        ),
        child: Text(
          model.label,
          style: AppStyles.mobileButtonMediumSb.copyWith(
            color: model.textColor,
          ),
        ),
      ),
    );
  }
}
