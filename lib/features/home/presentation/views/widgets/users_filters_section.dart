import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/features/home/data/enum/user_role.dart';
import 'package:sams_dashboard/features/home/data/enum/user_status.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_filters_row.dart';

class UsersFiltersSection extends StatefulWidget {
  const UsersFiltersSection({super.key});

  @override
  State<UsersFiltersSection> createState() => _UsersFiltersSectionState();
}

class _UsersFiltersSectionState extends State<UsersFiltersSection> {
  UserRole? selectedRole;
  UserStatus? selectedStatus;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: UsersFiltersRow(
        selectedRole: selectedRole,
        selectedStatus: selectedStatus,

        onRoleSelected: (role) {
          setState(() => selectedRole = role);
          log('Test: Filtered by Role -> ${role.name}');
        },

        onStatusSelected: (status) {
          setState(() => selectedStatus = status);
          log('Test: Filtered by Status -> ${status.name}');
        },

        onSearchChanged: (value) {
          searchQuery = value;
          log('Test: Typing search -> $value');
        },

        onClearFilters: () {
          setState(() {
            selectedRole = null;
            selectedStatus = null;
          });
          log('Test: All filters cleared');
        },

        onAddUserPressed: () {
          
          log('Test: Navigate to Add User Screen');
        },
      ),
    );
  }
}
