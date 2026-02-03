import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_dashboard/core/utils/router/routes_name.dart';
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
    return UsersFiltersRow(
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
        context.push(RoutesName.addUser);
        log('Test: Navigate to Add User Screen');
      },
    );
  }
}
