import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/enviroment/env.dart';
import 'package:todo_app/local_db/shared_preference.dart';
import 'package:todo_app/routing/router.dart';
import 'package:todo_app/screens/home/home_page.dart';
import 'package:todo_app/screens/todo_detail/todo_detail_page.dart';
import 'package:todo_app/utils/provider_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Supabase
  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  await saveUdid();

  runApp(
    ProviderScope(
      observers: [AppObserver()],
      child: const MyApp(),
    ),
  );
}

Future saveUdid() async {
  final deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    await SharedPreference.setUDID(androidInfo.id); // UDID cho Android
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    await SharedPreference.setUDID(
        iosInfo.identifierForVendor ?? 'unknown'); // UDID cho iOS
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: AppRouter().router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
          ),
        ),
        useMaterial3: true,
        fontFamily: "inter",
      ),
    );
  }
}
