import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/features/home/data/enum/user_role.dart';

class AddUserFormBody extends StatefulWidget {
  const AddUserFormBody({super.key});

  @override
  State<AddUserFormBody> createState() => _AddUserFormBodyState();
}

class _AddUserFormBodyState extends State<AddUserFormBody> {
  //* State variable to hold the selected dropdown value
  UserRole? _selectedRole;

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

            SizedBox(height: 16.h),

            _buildInputLabel('User ID'),
            _buildTextField(hint: 'e.g. 202202986'),

            SizedBox(height: 16.h),

            _buildInputLabel('Academic Email'),
            _buildTextField(hint: 'john@o6u.edu.eg'),

            SizedBox(height: 16.h),

            _buildInputLabel('Role'),
            //* Custom generic dropdown implementation
            _CustomDropdownField<UserRole>(
              value: _selectedRole,
              hintText: 'Select User Role',
              items: UserRole.values.map((item) {
                return DropdownMenuItem<UserRole>(
                  value: item,
                  child: Text(
                    item.label,
                    style: AppStyles.mobileLabelMediumRg.copyWith(
                      color: AppColors.whiteDarkHover,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedRole = val),
              validator: (value) =>
                  value == null ? 'Please select a role' : null,
            ),

            SizedBox(height: 16.h),

            _buildInputLabel('Password'),
            _buildTextField(
              hint: '••••••••',
            ),

            SizedBox(height: 16.h),

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

//* Private reusable dropdown widget for this file
class _CustomDropdownField<T> extends StatelessWidget {
  final T? value;
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;

  const _CustomDropdownField({
    required this.value,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      value: value,
      hint: Text(
        hintText,
        style: AppStyles.mobileLabelMediumRg.copyWith(
          color: AppColors.whiteDarkHover,
        ),
      ),
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: AppColors.secondary),
        ),
      ),
      items: items,
      onChanged: onChanged,
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColors.whiteDarkHover,
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondaryLightActive,
          ),
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.secondaryLight,
        ),
        //? Positioning the menu overlay relative to the field
        offset: const Offset(0, -6),
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 48.h,
      ),
      validator: validator,
    );
  }
}
