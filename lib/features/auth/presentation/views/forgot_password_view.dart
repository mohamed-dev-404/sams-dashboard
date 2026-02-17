import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_dashboard/core/enums/text_field_type.dart';
import 'package:sams_dashboard/core/helper/app_snack_bar.dart';
import 'package:sams_dashboard/core/models/app_button_style_model.dart';
import 'package:sams_dashboard/core/utils/assets/app_icons.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/router/routes_name.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/core/widgets/app_animated_loading_indicator.dart';
import 'package:sams_dashboard/core/widgets/app_button.dart';
import 'package:sams_dashboard/core/widgets/app_text_field.dart';
import 'package:sams_dashboard/core/widgets/svg_icon.dart';
import 'package:sams_dashboard/core/widgets/titled_input_field.dart';
import 'package:sams_dashboard/features/auth/presentation/view_models/password_reset_cubit/password_reset_cubit.dart';
import 'package:sams_dashboard/features/auth/presentation/view_models/password_reset_cubit/password_reset_state.dart';
import 'package:sams_dashboard/features/auth/presentation/views/widgets/auth_sider_image.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late PasswordResetCubit cubit;

  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
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
        } else if (state.status == PasswordResetStatus.codeSent) {
          context.push(RoutesName.verifyOtp);
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
                          _buildHeaderSection(),

                          const SizedBox(height: 32),

                          _buildEmailField(),

                          const SizedBox(height: 90),

                          (state.status == PasswordResetStatus.loading)
                              ? const AppAnimatedLoadingIndicator()
                              : AppButton(
                                  model: AppButtonStyleModel(
                                    label: 'Next Step',
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

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forgot Password',
          style: AppStyles.webTitleLargeMd.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'reset password?',
          style: AppStyles.web32Semibold.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Please enter your academic email\nto reset your password ',
          style: AppStyles.web24Regular.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TitledInputField(
      label: 'Academic Email',
      child: AppTextField(
        controller: _emailController,
        prefixIcon: const SvgIcon(
          AppIcons.iconsProfileEmail,
        ),
        hintText: 'example@example.com',
        textFieldType: TextFieldType.email,
        onFieldSubmitted: (_) {
          _submitForm();
        },
      ),
    );
  }

  void _submitForm() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      cubit.sendResetCode(email: _emailController.text.trim());
    }
  }
}
