import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:uv_intern_task05_todo/pages/edit_task_page.dart';
import 'package:uv_intern_task05_todo/pages/home_page.dart';
import 'package:uv_intern_task05_todo/pages/login_page.dart';
import 'package:uv_intern_task05_todo/pages/onboarding.dart';
import 'package:uv_intern_task05_todo/pages/register_page.dart';
import 'package:uv_intern_task05_todo/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/auth_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Onboarding(),
      // routes
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) =>  LoginPage(),
        '/register': (context) => RegisterPage(),
        '/auth': (context) => const AuthPage(),
        '/home': (context) => const HomePage(),
        '/editTask' : (context) => const EditTaskPage(),
      },
    );
  }
}
