import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_dashboard/core/helper/app_dialogs.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/core/utils/styles/app_styles.dart';
import 'package:sams_dashboard/core/widgets/app_animated_loading_indicator.dart';
import 'package:sams_dashboard/features/home/presentation/view_models/add_user/add_user_cubit.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/add_user/add_user_form_body.dart';

class AddUserView extends StatelessWidget {
  AddUserView({super.key});
  final GlobalKey<AddUserFormBodyState> _formKey =
      GlobalKey<AddUserFormBodyState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* Main Scaffold for the Add User screen
      body: BlocConsumer<AddUserCubit, AddUserState>(
        listener: (context, state) {
          if (state is AddUserSuccess) {
            _formKey.currentState?.resetForm();
            AppDialog.showSuccess(
              context,
              title: 'success',
              message: state.successMessage,
              onTap: () {
                context.pop();
              },
            );
          } else if (state is AddUserFailure) {
            AppDialog.showFailure(
              context,
              title: 'failed',
              message: state.errorMessage,
              onTap: () {
                context.pop();
              },
            );
          }
        },
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.only(left: 80.w, right: 80.w, top: 20.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //! Page Header Title
                  _addUserViewHeader(),
                  SizedBox(height: 16.h),
                  //* The Form Container (contains the actual input fields)
                  AddUserFormBody(key: _formKey),
                  SizedBox(height: 24.h),

                  state is AddUserLoading
                      ? const AppAnimatedLoadingIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            _formKey.currentState?.submitForm();
                          },
                          child: const Text('Add User'),
                        ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Text _addUserViewHeader() {
    return Text(
      'Add User',
      style: AppStyles.webTitleMediumMd.copyWith(
        color: AppColors.primaryDarkHover,
      ),
    );
  }
}
