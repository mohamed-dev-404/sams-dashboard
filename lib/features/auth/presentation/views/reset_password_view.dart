import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_dashboard/core/enums/password_field_type.dart';
import 'package:sams_dashboard/core/helper/app_dialogs.dart';
import 'package:sams_dashboard/core/helper/app_snack_bar.dart';
import 'package:sams_dashboard/core/models/app_button_style_model.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/router/routes_name.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/core/widgets/app_animated_loading_indicator.dart';
import 'package:sams_dashboard/core/widgets/app_button.dart';
import 'package:sams_dashboard/core/widgets/password_text_field.dart';
import 'package:sams_dashboard/core/widgets/titled_input_field.dart';
import 'package:sams_dashboard/features/auth/presentation/view_models/password_reset_cubit/password_reset_cubit.dart';
import 'package:sams_dashboard/features/auth/presentation/view_models/password_reset_cubit/password_reset_state.dart';
import 'package:sams_dashboard/features/auth/presentation/views/widgets/auth_sider_image.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late PasswordResetCubit cubit;

  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  late final FocusNode _confirmpassFocusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _confirmpassFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _confirmpassFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    cubit = context.read<PasswordResetCubit>();

    return BlocConsumer<PasswordResetCubit, PasswordResetState>(
      listener: (context, state) {
        if (state.status == PasswordResetStatus.failure) {
          AppSnackBar.error(
            context,
            state.errorMessage ?? 'unexpected error, please try again.',
          );
        } else if (state.status == PasswordResetStatus.success) {
          AppDialog.showSuccess(
            context,
            title: 'Password Reset Successfully!',
            message:
                state.successMessage ??
                'Your password has been changed. Please log in to continue to your dashboard.',
            onTap: () {
              context.go(RoutesName.login);
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              width <= 830
                  ? const SizedBox(
                      height: double.infinity,
                    )
                  : const AuthSiderImage(),
              const SizedBox(
                width: 42,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeaderText(),

                          const SizedBox(height: 32),

                          _buildResetPassFields(),

                          const SizedBox(height: 90),

                          (state.status == PasswordResetStatus.loading)
                              ? const AppAnimatedLoadingIndicator()
                              : AppButton(
                                  model: AppButtonStyleModel(
                                    label: 'Change Password',
                                    onPressed: () {
                                      _submitForm();
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderText() {
    return Text(
      'Reset Password',
      style: AppStyles.webTitleLargeMd.copyWith(
        color: AppColors.primaryDarkHover,
      ),
    );
  }

  Widget _buildResetPassFields() {
    return Column(
      spacing: 16,
      children: [
        TitledInputField(
          label: 'New Password',
          child: AppPasswordField(
            controller: _newPasswordController,
            hintText: 'enter new password',
            passwordFieldType: PasswordFieldType.originalPassword,
            onFieldSubmitted: (_) => FocusScope.of(
              context,
            ).requestFocus(_confirmpassFocusNode),
          ),
        ),
        TitledInputField(
          label: 'Confirm new Password',
          child: AppPasswordField(
            controller: _confirmPasswordController,
            originalController: _newPasswordController,
            focusNode: _confirmpassFocusNode,
            hintText: 'confirm your new password',
            passwordFieldType: PasswordFieldType.confirmPassword,
            onFieldSubmitted: (_) {
              _submitForm();
            },
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      cubit.resetPassword(
        newPassword: _newPasswordController.text.trim(),
        confirmPassword: _confirmPasswordController.text.trim(),
      );
    }
  }
}
