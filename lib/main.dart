import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/constants/app_colors.dart';
import 'package:todo_app/routing/router.dart';
import 'package:todo_app/screens/home/home_page.dart';
import 'package:todo_app/screens/todo_detail/todo_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Supabase
  await Supabase.initialize(url: "", anonKey: "");
  runApp(const MyApp());
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
