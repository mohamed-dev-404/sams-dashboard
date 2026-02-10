import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/features/home/data/enum/user_status.dart';

class UserStatusBadge extends StatelessWidget {
 final UserStatus status;

  const UserStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final bool isActive = status == UserStatus.active;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.secondaryLightActive
            : AppColors.redLightActive,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: AppStyles.web10Regular.copyWith(
          color: isActive
              ? AppColors.secondaryDarkHover
              : AppColors.redDarkHover,
        ),
      ),
    );
  }
}
