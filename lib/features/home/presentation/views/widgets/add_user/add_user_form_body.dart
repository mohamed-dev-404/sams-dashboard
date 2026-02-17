import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/enums/password_field_type.dart';
import 'package:sams_dashboard/core/enums/text_field_type.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/core/widgets/app_text_field.dart';
import 'package:sams_dashboard/core/widgets/password_text_field.dart';
import 'package:sams_dashboard/core/widgets/titled_input_field.dart';
import 'package:sams_dashboard/features/home/data/enum/user_role.dart';
import 'package:sams_dashboard/features/home/data/models/create_user_params.dart'
    show CreateUserParams;
import 'package:sams_dashboard/features/home/presentation/view_models/add_user/add_user_cubit.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/add_user/custom_dropdown_field.dart';

class AddUserFormBody extends StatefulWidget {
  const AddUserFormBody({super.key});

  @override
  State<AddUserFormBody> createState() => AddUserFormBodyState();
}

class AddUserFormBodyState extends State<AddUserFormBody> {
  //* State variable to hold the selected dropdown value
  UserRole? _selectedRole;

  late final TextEditingController _nameController;
  late final TextEditingController _iDController;

  late final TextEditingController _emailController;
  late final TextEditingController _roleController;

  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _iDController = TextEditingController();

    _emailController = TextEditingController();
    _roleController = TextEditingController();

    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _nameController.dispose();
    _iDController.dispose();

    _roleController.dispose();

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
                textFieldType: TextFieldType.normal,
                controller: _iDController,
              ),
            ),
            SizedBox(height: 16.h),
            TitledInputField(
              label: 'Academic Email',
              child: AppTextField(
                hintText: 'john@o6u.edu.eg',
                textFieldType: TextFieldType.academicEmail,
                controller: _emailController,
              ),
            ),

            SizedBox(height: 16.h),

            _buildInputLabel('Role'),
            //* Custom generic dropdown implementation
            CustomDropdownField<UserRole>(
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
              child: AppPasswordField(
                hintText: '••••••••',
                controller: _passwordController,
                passwordFieldType: PasswordFieldType.originalPassword,
              ),
            ),

            SizedBox(height: 16.h),
            TitledInputField(
              label: 'Confirm Password',
              child: AppPasswordField(
                hintText: '••••••••',
                originalController: _passwordController,
                passwordFieldType: PasswordFieldType.confirmPassword,
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

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      final params = CreateUserParams(
        name: _nameController.text,
        email: _emailController.text,
        academicId: _iDController.text,
        roleId: _selectedRole?.name ?? '',
        password: _passwordController.text,
      );
      context.read<AddUserCubit>().createUser(params);
    }
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _iDController.clear();
    _passwordController.clear();
    setState(() => _selectedRole = null);
  }
}
