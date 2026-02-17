import 'package:flutter/material.dart';
import 'package:sams_dashboard/core/utils/assets/app_icons.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/configs/size_config.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/features/home/data/enum/user_role.dart';
import 'package:sams_dashboard/features/home/data/enum/user_status.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/filters/custom_popup_menu_button.dart';

class UsersFiltersRow extends StatelessWidget {
  const UsersFiltersRow({
    super.key,

    // Search
    this.onSubmitted,

    // Add user
    this.onAddUserPressed,

    // Role filter
    this.selectedRole,
    this.onRoleSelected,

    // Status filter
    this.selectedStatus,
    this.onStatusSelected,

    // Clear
    this.onClearFilters,
    required this.controller,
  });

  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onAddUserPressed;
  final UserRole? selectedRole;
  final ValueChanged<UserRole>? onRoleSelected;
  final UserStatus? selectedStatus;
  final ValueChanged<UserStatus>? onStatusSelected;
  final VoidCallback? onClearFilters;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.primaryLight,
      child: w > SizeConfig.kSmallWebLayoutbreakPoint
          ? Row(
              children: [
                _UsersSearchField(
                  onSubmitted: onSubmitted,
                  controller: controller,
                ),
                const SizedBox(width: 12),
                _AddUserButton(onPressed: onAddUserPressed),
                const SizedBox(width: 8),
                _RoleFilter(
                  selectedRole: selectedRole,
                  onSelected: onRoleSelected,
                ),
                const SizedBox(width: 8),
                _StatusFilter(
                  selectedStatus: selectedStatus,
                  onSelected: onStatusSelected,
                ),
                const SizedBox(width: 8),
                ClearFiltersButton(onPressed: onClearFilters),
              ],
            )
          : Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      _UsersSearchField(
                        onSubmitted: onSubmitted,
                        controller: controller,
                      ),
                      const SizedBox(width: 8),
                      ClearFiltersButton(onPressed: onClearFilters),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _AddUserButton(onPressed: onAddUserPressed),
                    ),
                    const SizedBox(width: 8),
                    _RoleFilter(
                      selectedRole: selectedRole,
                      onSelected: onRoleSelected,
                    ),
                    const SizedBox(width: 8),
                    _StatusFilter(
                      selectedStatus: selectedStatus,
                      onSelected: onStatusSelected,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class _UsersSearchField extends StatelessWidget {
  const _UsersSearchField({this.onSubmitted, required this.controller});

  final ValueChanged<String>? onSubmitted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          fillColor: AppColors.whiteLight,
        ),
      ),
    );
  }
}

class _AddUserButton extends StatelessWidget {
  const _AddUserButton({this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      ),
      icon: const Icon(Icons.add),
      label: Text('Add User', style: AppStyles.mobileBodyXsmallRg),
    );
  }
}

class _RoleFilter extends StatelessWidget {
  const _RoleFilter({this.selectedRole, this.onSelected});
  final UserRole? selectedRole;
  final ValueChanged<UserRole>? onSelected;

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenuButton<UserRole>(
      label: 'Role',
      icon: AppIcons.roleIcon,
      items: UserRole.values,
      selectedValue: selectedRole,
      itemLabelBuilder: (role) => role.label,
      onSelected: (role) => onSelected?.call(role),
    );
  }
}

class _StatusFilter extends StatelessWidget {
  const _StatusFilter({this.selectedStatus, this.onSelected});

  final UserStatus? selectedStatus;
  final ValueChanged<UserStatus>? onSelected;

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenuButton<UserStatus>(
      label: 'Status',
      icon: AppIcons.statusIcon,
      items: UserStatus.values,
      selectedValue: selectedStatus,
      itemLabelBuilder: (status) => status.label,
      onSelected: (status) => onSelected?.call(status),
    );
  }
}

class ClearFiltersButton extends StatelessWidget {
  const ClearFiltersButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.clear),
      label: Text(
        'Clear Filters',
        style: AppStyles.webAgBodyRegular,
      ),
    );
  }
}
