import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';

class AddUserFormBody extends StatefulWidget {
  const AddUserFormBody({super.key});

  @override
  State<AddUserFormBody> createState() => _AddUserFormBodyState();
}

class _AddUserFormBodyState extends State<AddUserFormBody> {
  //* State variable to hold the selected dropdown value

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondary),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! Section Title
            Text(
              'User Information',
              style: AppStyles.web24Semibold.copyWith(
                color: AppColors.primaryDarkHover,
              ),
            ),
            SizedBox(height: 16.h),

            //! Form Input Fields
            _buildInputLabel('Full Name'),
            _buildTextField(hint: 'e.g. John Doe'),

            _buildInputLabel('User ID'),
            _buildTextField(hint: 'e.g. 202202986'),

            _buildInputLabel('Academic Email'),
            _buildTextField(hint: 'john@o6u.edu.eg'),

            _buildInputLabel('Password'),
            _buildTextField(
              hint: '••••••••',
            ),

            _buildInputLabel('Confirm Password'),
            _buildTextField(
              hint: '••••••••',
            ),
          ],
        ),
      ),
    );
  }

  //? Helper widget to build consistent field labels
  Widget _buildInputLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: AppStyles.webLabelMd.copyWith(
          color: AppColors.primaryDark,
        ),
      ),
    );
  }

  //? Helper widget to build consistent text input fields
  Widget _buildTextField({required String hint}) {
    return TextFormField(
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
      ),
    );
  }
}
