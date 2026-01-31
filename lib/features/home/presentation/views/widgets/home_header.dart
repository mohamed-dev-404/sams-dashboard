import 'package:flutter/material.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        'Admin Dashboard',
        style: AppStyles.web40Semibold,
      ),
    );
  }
}
