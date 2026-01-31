import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/configs/size_config.dart';
import 'package:sams_dashboard/core/utils/router/app_router.dart';
import 'package:sams_dashboard/core/utils/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: SizeConfig.webBaseSize,
      minTextAdapt: true,
      splitScreenMode: true,
      // Forces ScreenUtil to recalculate and rebuild the UI on every window resize
      rebuildFactor: (old, data) => RebuildFactors.always(old, data),
      builder: (context, child) {
        return MaterialApp.router(
          title: 'SAMS Dashboard',
          routerConfig: AppRouter.appRouter,
          theme: AppTheme.getAppTheme(),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          locale: DevicePreview.locale(context),
          builder: (context, widget) {
            // Integrate DevicePreview builder for screen testing
            widget = DevicePreview.appBuilder(context, widget);

            // Lock text scaling to ensure design consistency regardless of system settings
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: widget,
            );
          },
        );
      },
    );
  }
}
