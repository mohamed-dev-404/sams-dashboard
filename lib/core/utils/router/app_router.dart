import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_dashboard/core/utils/router/build_route.dart';
import 'package:sams_dashboard/core/utils/router/routes_name.dart';
import 'package:sams_dashboard/core/utils/services/service_locator.dart';
import 'package:sams_dashboard/core/widgets/general_error_page.dart';

// Repos & Cubits
import 'package:sams_dashboard/features/auth/data/repos/auth_repo.dart';
import 'package:sams_dashboard/features/auth/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:sams_dashboard/features/auth/presentation/view_models/password_reset_cubit/password_reset_cubit.dart';
import 'package:sams_dashboard/features/home/data/repos/home_repo.dart';
import 'package:sams_dashboard/features/home/presentation/view_models/home_cubit/home_cubit.dart';

// Views
import 'package:sams_dashboard/features/auth/presentation/views/login_view.dart';
import 'package:sams_dashboard/features/auth/presentation/views/forgot_password_view.dart';
import 'package:sams_dashboard/features/auth/presentation/views/verify_otp_view.dart';
import 'package:sams_dashboard/features/auth/presentation/views/reset_password_view.dart';
import 'package:sams_dashboard/features/home/presentation/views/add_user_view.dart';
import 'package:sams_dashboard/features/home/presentation/views/home_view.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final appRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutesName.login,
    errorBuilder: (context, state) => const GeneralErrorPage(),
    routes: [
      //* 1. LOGIN ROUTE
      buildRoute(
        name: RoutesName.login,
        path: RoutesName.login,
        builder: (context, state) => BlocProvider(
          create: (context) => LoginCubit(getIt<AuthRepo>()),
          child: const LoginView(),
        ),
      ),

      //* 2. PASSWORD RESET FLOW SHELL (Shared Cubit to all views)
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            // This instance lives as long as you are on any of the 3 routes below
            create: (context) => PasswordResetCubit(getIt<AuthRepo>()),
            child: child,
          );
        },
        routes: [
          GoRoute(
            name: RoutesName.forgotPassword,
            path: RoutesName.forgotPassword,
            builder: (context, state) => const ForgotPasswordView(),
          ),
          GoRoute(
            name: RoutesName.verifyOtp,
            path: RoutesName.verifyOtp,
            builder: (context, state) => const VerifyOtpView(),
          ),
          GoRoute(
            name: RoutesName.resetPassword,
            path: RoutesName.resetPassword,
            builder: (context, state) => const ResetPasswordView(),
          ),
        ],
      ),

      //* 3. HOME & DASHBOARD ROUTES
      buildRoute(
        name: RoutesName.home,
        path: RoutesName.home,
        builder: (context, state) => BlocProvider(
          lazy: false,
          create: (context) => HomeCubit(getIt<HomeRepo>())..getUsers(),
          child: const HomeView(),
        ),
      ),
      buildRoute(
        name: RoutesName.addUser,
        path: RoutesName.addUser,
        builder: (context, state) => const AddUserView(),
      ),
    ],
  );
}
