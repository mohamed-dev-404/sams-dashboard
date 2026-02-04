import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/features/home/data/enum/user_role.dart';

class RoleDropdown extends StatelessWidget {
  final UserRole currentRole;
  final ValueChanged<UserRole> onChanged;

  const RoleDropdown({
    super.key,
    required this.currentRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final otherRole = currentRole == UserRole.student
        ? UserRole.instructor
        : UserRole.student;

    return PopupMenuButton<UserRole>(
      offset: Offset(80.w, 45.h),
      color: AppColors.whiteLight,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(color: AppColors.primaryLightHover),
      ),
      onSelected: onChanged,
      itemBuilder: (context) => [
        PopupMenuItem<UserRole>(
          value: otherRole,
          height: 40.h,
          child: Center(
            child: Text(
              otherRole.label,
              style: AppStyles.mobileBodyXsmallRg.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            currentRole.label,
            style: AppStyles.mobileBodyXsmallRg.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(width: 4.w),
          Icon(
            Icons.keyboard_arrow_down,
            size: 16.sp,
            color: AppColors.primaryDark,
          ),
        ],
      ),
    );
  }
}
