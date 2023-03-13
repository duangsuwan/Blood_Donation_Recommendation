import 'package:blood_donation_recommendation/constants/routes.dart';
import 'package:blood_donation_recommendation/views/login_page.dart';
import 'package:blood_donation_recommendation/views/profile_page.dart';
import 'package:blood_donation_recommendation/views/result_page.dart';
import 'package:blood_donation_recommendation/views/search_page.dart';
import 'package:blood_donation_recommendation/views/register_page.dart';
import 'package:blood_donation_recommendation/views/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools
      ],
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Blood Donation Event Recommendation',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: loginRoute,
      routes: {
        loginRoute: (context) => const LogInPage(),
        registerRoute: (context) => const RegisterPage(),
        searchRoute: (context) => const SearchPage(),
        profileRoute: (context) => const ProfilePage(),
        settingsRoute: (context) => const SettingsPage(),
        resultRoute: (context) => const ResultPage(),
      }
    );
  }
}