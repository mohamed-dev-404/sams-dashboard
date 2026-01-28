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
      // Use web design size only
      designSize: SizeConfig.webBaseSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'SAMS Dashboard',
          routerConfig: AppRouter.appRouter,
          theme: AppTheme.getAppTheme(),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          // DevicePreview configuration (optional - remove if not needed for testing)
          locale: DevicePreview.locale(context),
          builder: (context, widget) {
            // 1. Wrap with DevicePreview builder first (optional)
            widget = DevicePreview.appBuilder(context, widget);
            
            // 2. Initialize ScreenUtil with web design size
            ScreenUtil.init(
              context,
              designSize: SizeConfig.webBaseSize,
            );
            
            // 3. Get system MediaQuery data
            final systemData = MediaQuery.of(context);
            
            // 4. Lock text scaling to maintain design consistency
            final modifiedData = systemData.copyWith(
              textScaler: const TextScaler.linear(1.0),
            );
            
            // 5. Provide modified data to all screens
            return MediaQuery(
              data: modifiedData,
              child: widget,
            );
          },
        );
      },
    );
  }
}