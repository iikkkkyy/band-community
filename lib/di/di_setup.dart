import 'package:get_it/get_it.dart';

import '../presentation/login/login_view_model.dart';
import '../presentation/profile/profile_view_model.dart';
import '../presentation/resetpassword/reset_password_view_model.dart';
import '../presentation/signup/signup_screen_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerFactory(() => SignUpViewModel());
  getIt.registerFactory(() => LoginViewModel());
  getIt.registerFactory(() => ResetPasswordViewModel());
  getIt.registerFactory(() => SignUpProfileViewModel());
}