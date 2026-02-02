import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/home_header.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_management_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 90.w, vertical: 24.h),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(),
            SizedBox(height: 24),
            Expanded(child: UsersManagementSection()),
          ],
        ),
      ),
    );
  }
}
