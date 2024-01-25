import 'package:band_community/presentation/login/login_screen.dart';
import 'package:band_community/presentation/login/login_view_model.dart';
import 'package:band_community/presentation/signup/signup_screen.dart';
import 'package:band_community/presentation/signup/signup_screen_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'di/di_setup.dart';


final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<LoginViewModel>(),
        child: const LoginScreen(),
      ),
      routes: [
        GoRoute(
          path: 'signup',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => getIt<SignUpViewModel>(),
            child: const SignUpScreen(),
          ),
        ),
      ]
    ),

  ],
);
