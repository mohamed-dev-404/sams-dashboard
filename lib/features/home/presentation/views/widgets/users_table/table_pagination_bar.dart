import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/features/home/data/models/user_pagination_model.dart';
import 'package:sams_dashboard/features/home/presentation/view_models/home_cubit/home_cubit.dart';

//*) Pagination bar widget for table navigation
class TablePaginationBar extends StatelessWidget {
  const TablePaginationBar({
    super.key,
    required this.userPaginationModel,
  });

  final UserPaginationModel userPaginationModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //*) Left side: page navigation controls
        _buildNavigationControls(userPaginationModel, context),

        //*) Right side: rows-per-page selector
        _buildRowsPerPageControls(context),
      ],
    );
  }

  //*) Navigation Controls (Left Section)

  Widget _buildNavigationControls(
    UserPaginationModel userPaginationModel,
    BuildContext context,
  ) {
    return Row(
      children: [
        _buildNavButton(
          icon: Icons.chevron_left,
          onTap: userPaginationModel.hasPrevPage
              ? () {
                  BlocProvider.of<HomeCubit>(
                    context,
                  ).updatePage(
                    userPaginationModel.currentPage - 1,
                  );
                }
              : null,
        ),
        SizedBox(width: 8.w),
        _buildPageNumberBox(userPaginationModel.currentPage),
        SizedBox(width: 8.w),
        _buildNavButton(
          icon: Icons.chevron_right,
          onTap: userPaginationModel.hasNextPage
              ? () {
                  BlocProvider.of<HomeCubit>(
                    context,
                  ).updatePage(
                    userPaginationModel.currentPage + 1,
                  );
                }
              : null,
        ),
        SizedBox(width: 12.w),
        Text(
          'of ${userPaginationModel.totalPages} pages',
          style: AppStyles.mobileBodySmallRg.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
      ],
    );
  }

  //*) Rows Per Page Controls (Right Section)

  //? Builds rows-per-page label and selector
  Widget _buildRowsPerPageControls(
    BuildContext context,
  ) {
    return Row(
      children: [
        Text(
          'Showing',
          style: AppStyles.mobileBodySmallRg.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        SizedBox(width: 8.w),
        _buildRowsPerPageSelector(context),
        SizedBox(width: 8.w),
        Text(
          'items per page',
          style: AppStyles.mobileBodySmallRg.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
      ],
    );
  }

  //*) Helper Widgets

  //? Builds a navigation button with disabled state handling
  Widget _buildNavButton({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    final bool isDisabled = onTap == null;

    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: isDisabled ? AppColors.whiteHover : AppColors.primary,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: isDisabled ? AppColors.whiteDark : AppColors.whiteLight,
            size: 20.sp,
          ),
        ),
      ),
    );
  }

  //? Displays the current page number
  Widget _buildPageNumberBox(int page) {
    return Container(
      width: 32.w,
      height: 36.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.whiteLight,
        border: Border.all(
          color: AppColors.whiteDarkHover,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        '$page',
        style: AppStyles.mobileBodyXsmallMd.copyWith(
          color: AppColors.primaryDark,
        ),
      ),
    );
  }

  //? Popup menu for selecting rows per page

  Widget _buildRowsPerPageSelector(
    BuildContext context,
  ) {
    return PopupMenuButton<int>(
      initialValue: userPaginationModel.size,
      onSelected: (numOfUsers) {
        BlocProvider.of<HomeCubit>(
          context,
        ).updatePageSize(numOfUsers);
      },
      offset: const Offset(0, 40),
      elevation: 4,
      color: AppColors.whiteLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(
          color: AppColors.primaryLightHover,
        ),
      ),
      itemBuilder: (context) => [5, 10, 15, 20]
          .map(
            (val) => PopupMenuItem<int>(
              value: val,
              height: 40.h,
              child: Center(
                child: Text(
                  '$val',
                  style: AppStyles.mobileBodyXsmallMd.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          )
          .toList(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.whiteDarkHover,
          ),
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.whiteLight,
        ),
        child: Row(
          children: [
            Text(
              userPaginationModel.size.toString(),
              style: AppStyles.mobileTitleXsmallMd.copyWith(
                color: AppColors.primaryDark,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16.sp.clamp(16, 18),
              color: AppColors.whiteDarkActive,
            ),
          ],
        ),
      ),
    );
  }
}
