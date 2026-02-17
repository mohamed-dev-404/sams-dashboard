import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:sams_dashboard/app_initializer.dart';
import 'package:sams_dashboard/my_app.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Removes the '#' from the URL
  usePathUrlStrategy();
  // Add this line to fix the URL not changing on push
  GoRouter.optionURLReflectsImperativeAPIs = true;
  // Initialize app services
  await AppInitializer.init();

  runApp(
    DevicePreview(
      enabled: false, //?kReleaseMode ? false : true,
      builder: (context) => const MyApp(),
    ),
  );
}
