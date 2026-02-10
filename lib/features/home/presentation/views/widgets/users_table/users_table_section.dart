import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/constants/api_keys.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/features/home/data/enum/user_status.dart';
import 'package:sams_dashboard/features/home/data/models/user_model.dart';
import 'package:sams_dashboard/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_table/role_dropdown.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_table/user_status_badge.dart';

/// ================= USERS TABLE SECTION =================
/// Main widget responsible for rendering users data table

class UsersTableSection extends StatelessWidget {
  const UsersTableSection({super.key, required this.users});
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = context.read<HomeCubit>();
    return DataTable2(
      sortArrowIconColor: AppColors.whiteLight,
      sortArrowIcon: Icons.swap_vert_rounded,
      sortColumnIndex: cubit.currentSortColumnIndex,
      sortAscending: cubit.isAscending,
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 800,
      headingRowHeight: 50.h,
      dataRowHeight: 70.h,
      headingRowColor: WidgetStateProperty.all(AppColors.primary),
      headingTextStyle: AppStyles.mobileBodyXsmallRg.copyWith(
        color: Colors.white,
      ),
      columns: _buildColumns(context), // Pass context if needed for sorting
      rows: users
          .asMap()
          .entries
          .map((e) => _buildUserRow(context, e.value, e.key))
          .toList(),
    );
  }

  List<DataColumn> _buildColumns(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return [
      _createSortableColumn(
        context,
        'ID',
        ColumnSize.S,
        ApiValues.academicId,
        0,
        cubit.currentSortColumnIndex,
      ),
      _createSortableColumn(
        context,
        'Name',
        ColumnSize.L,
        ApiValues.name,
        1,
        cubit.currentSortColumnIndex,
      ),
      _createSortableColumn(
        context,
        'Email/Academic',
        ColumnSize.L,
        ApiValues.academicEmail,
        2,
        cubit.currentSortColumnIndex,
      ),
      const DataColumn2(label: Text('Status'), size: ColumnSize.M),
      const DataColumn2(label: Text('Role'), size: ColumnSize.M),
    ];
  }

  DataRow _buildUserRow(BuildContext context, UserModel user, int index) {
    final cellStyle = AppStyles.mobileBodyXsmallRg.copyWith(
      color: AppColors.primaryDark,
    );

    return DataRow(
      color: WidgetStateProperty.all(
        index.isEven ? AppColors.white : AppColors.whiteHover,
      ),
      cells: [
        DataCell(Text(user.academicId, style: cellStyle)),
        DataCell(Text(user.name, style: cellStyle)),
        DataCell(Text(user.email, style: cellStyle)),
        DataCell(
          _StatusActionCell(
            user: user,
            onToggle: () {
              // Now we can safely access context
              BlocProvider.of<HomeCubit>(
                context,
              ).toggleActivation(userId: user.id);
            },
          ),
        ),
        DataCell(
          RoleDropdown(
            currentRole: user.role,
            onChanged: (newRoleId) {
              BlocProvider.of<HomeCubit>(
                context,
              ).changeUserRole(
                userId: user.id,
                newRole: newRoleId,
              );
            },
          ),
        ),
      ],
    );
  }

  DataColumn2 _createSortableColumn(
    BuildContext context,
    String label,
    ColumnSize size,
    String fieldName,
    int index,
    int currentActiveIndex,
  ) {
    return DataColumn2(
      label: _SortableHeader(
        title: label,
        index: index,
        currentIndex: currentActiveIndex,
      ),
      size: size,
      onSort: (columnIndex, ascending) {
        context.read<HomeCubit>().sortUsers(
          sortBy: fieldName,
          ascending: ascending,
          columnIndex: columnIndex,
        );
      },
    );
  }
}

//! ========================== widget =======================

/// ================= SORTABLE HEADER =================
/// Column header with sort icon indicator
class _SortableHeader extends StatelessWidget {
  final String title;
  final int index;
  final int currentIndex;

  const _SortableHeader({
    required this.title,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        if (currentIndex != index)
          Padding(
            padding: EdgeInsetsDirectional.only(start: 4.w),
            child: Icon(
              Icons.swap_vert_rounded,
              size: 16.sp,
              color: AppColors.whiteLight.withValues(alpha: 0.6),
            ),
          ),
      ],
    );
  }
}

/// ================= STATUS CELL =================
/// Status badge + active/inactive switch
class _StatusActionCell extends StatelessWidget {
  final UserModel user;
  final VoidCallback onToggle;

  const _StatusActionCell({
    required this.user,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserStatusBadge(status: user.status),
        SizedBox(width: 8.w),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: user.status == UserStatus.active,
            inactiveThumbColor: AppColors.red,
            activeThumbColor: AppColors.secondary,
            onChanged: (value) {
              // user.status = value ? UserStatus.active : UserStatus.inactive;
              onToggle(); // refresh UI
            },
          ),
        ),
      ],
    );
  }
}
