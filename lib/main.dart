import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/init/init_dependencies.dart';
import 'core/config/app_config.dart';
import 'core/constants/app_colors.dart';
import 'core/routes/route_helper.dart';
import 'core/bindings/initial_binding.dart';
import 'core/services/google_sheets_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
  try {
    print('Initializing Google Sheets...');
    await GoogleSheetsService.init();
    print('Google Sheets initialized');
  } catch (e) {
    print('Error initializing Google Sheets: $e');
  }
  
  // Add error handling
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 40,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: TextStyle(color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  };

  try {
    await InitialBinding().dependencies();
    
    runApp(const MyApp());
  } catch (e) {
    print('Error during initialization: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Purify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: RouteHelper.splash,
      getPages: RouteHelper.routes,
      defaultTransition: Transition.fadeIn,
    );
  }
}
