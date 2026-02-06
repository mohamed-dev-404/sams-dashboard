import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_filters_section.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_table_section.dart';

//*) Users management main section (Filters + Table + Pagination)
class UsersManagementSection extends StatelessWidget {
  const UsersManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Dialog(
              backgroundColor: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is HomeSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UsersFiltersSection(),

                //*) Table Section (listens to page & rows changes)
                Expanded(
                  child: state.userResponse.users.isEmpty
                      ? _buildEmptyState()
                      : UsersTableSection(users: state.userResponse.users),
                ),

                const Divider(height: 1, color: AppColors.whiteHover),
                SizedBox(height: 24.h),

                //*) Pagination Bar Section
                // TablePaginationBar(
                //   totalItems: state.userResponse.pagination.totalElements,
                //   currentPage: state.userResponse.pagination.currentPage,
                //   rowsPerPage: state.userResponse.pagination.size,
                //   onRowsPerPageChanged: (newRows) {
                //     context.read<HomeCubit>().updatePagination(limit: newRows, page: 1);
                //     //! Reset page when rows-per-page changes
                //     state.userResponse.pagination.size = newRows;
                //     state.userResponse.pagination.currentPage = 1;
                //   },
                //   onPageChanged: (newPage) {
                //     state.userResponse.pagination.currentPage = newPage;
                //   },
                // ),
              ],
            );
          } else if (state is HomeFailure) {
            return Center(
              child: Text(state.errMessage),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 64.sp,
            color: AppColors.whiteHover,
          ),
          SizedBox(height: 16.h),
          Text(
            'No users found',
            style: AppStyles.mobileBodyLargeRg.copyWith(
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
