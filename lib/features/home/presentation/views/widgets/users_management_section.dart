import 'package:flutter/material.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_filters_section.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_table_section.dart';

//! Users Management Main Section
//! Combines filters and users table in one container
class UsersManagementSection extends StatelessWidget {
  const UsersManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //* Section padding & background
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),

      //* Layout: filters on top, table fills space
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //? Users filters (search, role, status)
          UsersFiltersSection(),

          //? Users table (expand to available height)
          Expanded(
            child: UsersTableSection(),
          ),
        ],
      ),
    );
  }
}
