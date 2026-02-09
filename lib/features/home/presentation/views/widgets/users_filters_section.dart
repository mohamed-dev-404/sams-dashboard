import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_dashboard/core/utils/router/routes_name.dart';
import 'package:sams_dashboard/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_filters_row.dart';

class UsersFiltersSection extends StatelessWidget {
  const UsersFiltersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return UsersFiltersRow(
      selectedRole: cubit.selectedRoleEnum,
      selectedStatus: cubit.selectedStatusEnum,

      onRoleSelected: (role) {
        cubit.applyFilters(role: role);
      },

      onStatusSelected: (status) {
        cubit.applyFilters(status: status);
      },

      onSubmitted: (value) {
        context.read<HomeCubit>().onSearchSubmitted(value);
      },

      onClearFilters: () => cubit.clearFilters(),

      onAddUserPressed: () => context.push(RoutesName.addUser),

      controller: context.read<HomeCubit>().searchController,
    );
  }
}
