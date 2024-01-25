import 'package:band_community/presentation/login/login_screen.dart';
import 'package:band_community/presentation/login/login_view_model.dart';
import 'package:band_community/presentation/signup/signup_screen.dart';
import 'package:band_community/presentation/signup/signup_screen_view_model.dart';
import 'package:band_community/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'di/di_setup.dart';
import 'firebase_options.dart';

void main() async {
  diSetup();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
    );
  }
}
