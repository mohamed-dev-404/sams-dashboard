import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/enums/text_field_type.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/core/widgets/app_text_field.dart';
import 'package:sams_dashboard/core/widgets/titled_input_field.dart';
import 'package:sams_dashboard/features/home/data/enum/user_role.dart';

class AddUserFormBody extends StatefulWidget {
  const AddUserFormBody({super.key});

  @override
  State<AddUserFormBody> createState() => _AddUserFormBodyState();
}

class _AddUserFormBodyState extends State<AddUserFormBody> {
  //* State variable to hold the selected dropdown value
  UserRole? _selectedRole;

  late final TextEditingController _nameController;
  late final TextEditingController _iDController;

  late final TextEditingController _emailController;
  late final TextEditingController _roleController;

  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _iDController = TextEditingController();

    _emailController = TextEditingController();
    _roleController = TextEditingController();

    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _nameController.dispose();
    _iDController.dispose();

    _roleController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondary),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Form(
        key: _formKey,
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
            TitledInputField(
              label: 'Full Name',
              child: AppTextField(
                hintText: 'e.g. John Doe',
                textFieldType: TextFieldType.alphabetical,
                controller: _nameController,
              ),
            ),
            SizedBox(height: 16.h),
            TitledInputField(
              label: 'User ID',
              child: AppTextField(
                hintText: 'e.g. 202202986',
                textFieldType: TextFieldType.alphabetical,
                controller: _iDController,
              ),
            ),
            SizedBox(height: 16.h),
            TitledInputField(
              label: 'Academic Email',
              child: AppTextField(
                hintText: 'john@o6u.edu.eg',
                textFieldType: TextFieldType.alphabetical,
                controller: _emailController,
              ),
            ),

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
            TitledInputField(
              label: 'Password',
              child: AppTextField(
                hintText: '••••••••',
                textFieldType: TextFieldType.alphabetical,
                controller: _passwordController,
              ),
            ),

            SizedBox(height: 16.h),
            TitledInputField(
              label: 'Confirm Password',
              child: AppTextField(
                hintText: '••••••••',
                textFieldType: TextFieldType.alphabetical,
                controller: _confirmPasswordController,
              ),
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
