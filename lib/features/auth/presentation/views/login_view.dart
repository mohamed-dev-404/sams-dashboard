import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_dashboard/core/enums/password_field_type.dart';
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
import 'package:sams_dashboard/core/widgets/password_text_field.dart';
import 'package:sams_dashboard/core/widgets/svg_icon.dart';
import 'package:sams_dashboard/core/widgets/titled_input_field.dart';
import 'package:sams_dashboard/features/auth/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:sams_dashboard/features/auth/presentation/view_models/login_cubit/login_state.dart';
import 'package:sams_dashboard/features/auth/presentation/views/widgets/auth_sider_image.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _passFocusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          AppSnackBar.error(context, state.errorMessage);
        } else if (state is LoginSuccess) {
          context.go(RoutesName.home); //navigate to home
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

                          _buildEmailField(),

                          const SizedBox(height: 16),

                          _buildPasswordField(context),

                          const SizedBox(height: 16),

                          _buildForgetPassButton(),

                          const SizedBox(height: 90),

                          (state is LoginLoading)
                              ? const AppAnimatedLoadingIndicator()
                              : AppButton(
                                  model: AppButtonStyleModel(
                                    label: 'Log In',
                                    onPressed: () {
                                      _submitForm(context);
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
      'Log In',
      style: AppStyles.webTitleLargeMd.copyWith(
        color: AppColors.primaryDarkHover,
      ),
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
        onFieldSubmitted: (_) => FocusScope.of(
          context,
        ).requestFocus(_passFocusNode),
      ),
    );
  }

  Widget _buildPasswordField(BuildContext myContext) {
    return TitledInputField(
      label: 'Password',
      child: AppPasswordField(
        controller: _passwordController,
        focusNode: _passFocusNode,
        hintText: 'Enter your password',
        passwordFieldType: PasswordFieldType.originalPassword,
        onFieldSubmitted: (_) {
          _submitForm(myContext);
        },
      ),
    );
  }

  Widget _buildForgetPassButton() {
    return Align(
      alignment: AlignmentGeometry.centerRight,
      child: GestureDetector(
        onTap: () {
          context.push(RoutesName.forgotPassword);
        },
        child: Text(
          'Forgot Password?',
          style: AppStyles.mobileTitleSmallSb.copyWith(
            color: AppColors.primaryDarkHover,
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext myContext) {
    final bool isValid = _formKey.currentState!.validate();
    final cubit = myContext.read<LoginCubit>();
    if (isValid) {
      cubit.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }
}
