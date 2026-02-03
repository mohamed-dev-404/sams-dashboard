import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';

//*) Pagination bar widget for table navigation
class TablePaginationBar extends StatelessWidget {
  const TablePaginationBar({
    super.key,
    required this.totalItems,
    required this.rowsPerPage,
    required this.currentPage,
    required this.onRowsPerPageChanged,
    required this.onPageChanged,
  });

  final int totalItems; // Total number of items in the table

  final int rowsPerPage; // Number of rows shown per page

  final int currentPage; // Current active page (1-based index)

  // Callback when rows-per-page value changes
  final Function(int) onRowsPerPageChanged;

  final Function(int) onPageChanged; //Callback when page number changes

  @override
  Widget build(BuildContext context) {
    //! Calculate total pages safely (minimum = 1)
    final int totalPages = (totalItems / rowsPerPage)
        .ceil()
        .clamp(1, double.infinity)
        .toInt();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //*) Left side: page navigation controls
        _buildNavigationControls(totalPages),

        //*) Right side: rows-per-page selector
        _buildRowsPerPageControls(),
      ],
    );
  }

  //*) ------------------------------------------------------------------------
  //*) Navigation Controls (Left Section)
  //*) ------------------------------------------------------------------------

  //? Builds previous/next buttons and current page indicator
  Widget _buildNavigationControls(int totalPages) {
    return Row(
      children: [
        _buildNavButton(
          icon: Icons.chevron_left,
          //? Disable button when already on first page
          onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
        ),
        SizedBox(width: 8.w),
        _buildPageNumberBox(currentPage),
        SizedBox(width: 8.w),
        _buildNavButton(
          icon: Icons.chevron_right,
          //? Disable button when already on last page
          onTap: currentPage < totalPages
              ? () => onPageChanged(currentPage + 1)
              : null,
        ),
        SizedBox(width: 12.w),
        Text(
          'of $totalPages pages',
          style: AppStyles.mobileBodySmallRg.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
      ],
    );
  }

  //*) ------------------------------------------------------------------------
  //*) Rows Per Page Controls (Right Section)
  //*) ------------------------------------------------------------------------

  //? Builds rows-per-page label and selector
  Widget _buildRowsPerPageControls() {
    return Row(
      children: [
        Text(
          'Showing',
          style: AppStyles.mobileBodySmallRg.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        SizedBox(width: 8.w),
        _buildRowsPerPageSelector(),
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

  //*) ------------------------------------------------------------------------
  //*) Helper Widgets
  //*) ------------------------------------------------------------------------

  //? Builds a navigation button with disabled state handling
  Widget _buildNavButton({
    required IconData icon,
    VoidCallback? onTap,
  }) {
    //! Button is disabled when onTap is null
    final bool isDisabled = onTap == null;

    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32.w,
          height: 36.h,
          decoration: BoxDecoration(
            //? Use faded color when disabled
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
  Widget _buildRowsPerPageSelector() {
    return PopupMenuButton<int>(
      initialValue: rowsPerPage,
      onSelected: onRowsPerPageChanged,
      offset: const Offset(0, 40),
      elevation: 4,
      color: AppColors.whiteLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: const BorderSide(
          color: AppColors.primaryLightHover,
        ),
      ),
      itemBuilder: (context) => [5, 10, 15, 20, 50]
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
        child: Text(
          rowsPerPage.toString(),
          style: AppStyles.mobileTitleXsmallMd.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
      ),
    );
  }
}
