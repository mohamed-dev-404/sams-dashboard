import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/features/home/data/enum/user_status.dart';
import 'package:sams_dashboard/features/home/data/models/user_model.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/role_dropdown.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/user_status_badge.dart';

/// ================= USERS TABLE SECTION =================
/// Main widget responsible for rendering users data table
class UsersTableSection extends StatefulWidget {
  final List<UserModel> users;

  const UsersTableSection({super.key, required this.users});
  @override
  State<UsersTableSection> createState() => _UsersTableSectionState();
}

class _UsersTableSectionState extends State<UsersTableSection> {
  int _currentSortIndex = 0; // current sorted column index
  bool _isAscending = true; // sort direction

  @override
  Widget build(BuildContext context) {
    final displayUsers = widget.users;
    return DataTable2(
      //* Sorting config
      sortArrowIconColor: AppColors.whiteLight,
      sortArrowIcon: Icons.swap_vert_rounded,
      sortColumnIndex: _currentSortIndex,
      sortAscending: _isAscending,

      //* Layout config
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 800,
      headingRowHeight: 50.h,
      dataRowHeight: 70.h,

      //* Header style
      headingRowColor: WidgetStateProperty.all(AppColors.primary),
      headingTextStyle: AppStyles.mobileBodyXsmallRg.copyWith(
        color: Colors.white,
      ),

      //* Table structure
      columns: _buildColumns(),
      rows: displayUsers
          .asMap()
          .entries
          .map((e) => _buildUserRow(e.value, e.key))
          .toList(),
    );
  }

  ///* Build table columns
  List<DataColumn> _buildColumns() {
    return [
      _createSortableColumn('ID', ColumnSize.S, (u) => u.id, 0),
      _createSortableColumn('Name', ColumnSize.L, (u) => u.name, 1),
      _createSortableColumn('Email/Academic', ColumnSize.L, (u) => u.email, 2),
      const DataColumn2(label: Text('Status'), size: ColumnSize.M),
      const DataColumn2(label: Text('Role'), size: ColumnSize.M),
    ];
  }

  ///* Reusable sortable column builder
  DataColumn2 _createSortableColumn(
    String label,
    ColumnSize size,
    Comparable Function(UserModel) getField,
    int index,
  ) {
    return DataColumn2(
      label: _SortableHeader(
        title: label,
        index: index,
        currentIndex: _currentSortIndex,
      ),
      size: size,
      onSort: (idx, asc) => _sortUsers(getField, idx, asc),
    );
  }

  ///* Build single user row
  DataRow _buildUserRow(UserModel user, int index) {
    final cellStyle = AppStyles.mobileBodyXsmallRg.copyWith(
      color: AppColors.primaryDark,
    );

    return DataRow(
      //* Zebra rows
      color: WidgetStateProperty.all(
        index.isEven ? AppColors.white : AppColors.whiteHover,
      ),
      cells: [
        DataCell(Text(user.id, style: cellStyle)),
        DataCell(Text(user.name, style: cellStyle)),
        DataCell(Text(user.email, style: cellStyle)),
        DataCell(
          _StatusActionCell(
            user: user,
            onToggle: () => setState(() {}),
          ),
        ),
        DataCell(
          RoleDropdown(
            currentRole: user.role,
            onChanged: (newRole) => setState(() => user.role = newRole),
          ),
        ),
      ],
    );
  }

  ///* Generic sorting logic for any column
  void _sortUsers(
    Comparable Function(UserModel u) getField,
    int index,
    bool asc,
  ) {
    setState(() {
      _currentSortIndex = index;
      _isAscending = asc;

      widget.users.sort(
        (a, b) => asc
            ? getField(a).compareTo(getField(b))
            : getField(b).compareTo(getField(a)),
      );
    });
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
              user.status = value ? UserStatus.active : UserStatus.inactive;
              onToggle(); // refresh UI
            },
          ),
        ),
      ],
    );
  }
}
