import 'package:band_community/presentation/login/login_screen.dart';
import 'package:band_community/presentation/login/login_view_model.dart';
import 'package:band_community/presentation/profile/profile_screen.dart';
import 'package:band_community/presentation/profile/profile_view_model.dart';
import 'package:band_community/presentation/resetpassword/reset_password_screen.dart';
import 'package:band_community/presentation/resetpassword/reset_password_view_model.dart';
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
          GoRoute(
            path: 'reset',
            builder: (context, state) => ChangeNotifierProvider(
              create: (_) => getIt<ResetPasswordViewModel>(),
              child: const ResetPasswordScreen(),
            ),
          ),
        ]),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<SignUpProfileViewModel>(),
        child: const SignUpProfileScreen(),
      ),
    ),
  ],
);
