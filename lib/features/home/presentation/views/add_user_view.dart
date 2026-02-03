import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/add_user_form_body.dart';

class AddUserView extends StatelessWidget {
  const AddUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* Main Scaffold for the Add User screen
      body: Container(
        margin: EdgeInsets.only(left: 80.w, right: 80.w, top: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //! Page Header Title
            Text(
              'Add User',
              style: AppStyles.webTitleMediumMd.copyWith(
                color: AppColors.primaryDarkHover,
              ),
            ),

            Flexible(child: SizedBox(height: 16.h)),

            //* The Form Container (contains the actual input fields)
            const AddUserFormBody(),

            Flexible(child: SizedBox(height: 24.h)),

            // TODO: Connect this button to the AddUser Cubit/Logic
            ElevatedButton(
              onPressed: () {
                //! Validate and Submit Logic
              },
              child: const Text('Add User'),
            ),

            Flexible(child: SizedBox(height: 24.h)),
          ],
        ),
      ),
    );
  }
}
