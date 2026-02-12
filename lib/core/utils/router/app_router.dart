import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_dashboard/core/utils/router/build_route.dart';
import 'package:sams_dashboard/core/utils/router/routes_name.dart';
import 'package:sams_dashboard/core/utils/services/service_locator.dart';
import 'package:sams_dashboard/core/widgets/general_error_page.dart';
import 'package:sams_dashboard/features/home/data/repos/home_repo.dart';
import 'package:sams_dashboard/features/home/presentation/view_models/add_user/add_user_cubit.dart';
import 'package:sams_dashboard/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:sams_dashboard/features/home/presentation/views/add_user_view.dart';
import 'package:sams_dashboard/features/home/presentation/views/home_view.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final appRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutesName.home,
    errorBuilder: (context, state) => const GeneralErrorPage(),
    routes: [
      buildRoute(
        name: RoutesName.home,
        path: RoutesName.home,
        builder: (context, state) => BlocProvider(
          lazy: false,
          create: (context) => HomeCubit(getIt<HomeRepo>())..initHome(),
          child: const HomeView(),
        ),
      ),
      buildRoute(
        name: RoutesName.addUser,
        path: RoutesName.addUser,
        builder: (context, state) => BlocProvider(
          create: (context) => AddUserCubit(getIt<HomeRepo>()),
          child: AddUserView(),
        ),
      ),

      /// buildRoute(
      ///   name: RoutesName.homeView,
      ///   path: RoutesName.homeView,
      ///   builder: (context, state) {
      ///     final args = state.extra as UserModel;
      ///    return BlocProvider(
      ///       create: (context) => sl<HomeCubit>(),
      ///       child: Homeview(args: args),
      ///     );
      ///   },
      ///),
      //... more buildRoute calls
    ],
  );
}
