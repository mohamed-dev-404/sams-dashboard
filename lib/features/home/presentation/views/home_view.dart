import 'package:flutter/material.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/home_header.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_filters_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 90, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(),
            SizedBox(height: 24),
            UsersFiltersSection(),
          ],
        ),
      ),
    );
  }
}
