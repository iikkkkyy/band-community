import 'package:band_community/domain/use_case/auth/sign_in_use_case.dart';
import 'package:band_community/domain/use_case/auth/sign_in_with_kakao_use_case.dart';
import 'package:band_community/presentation/mainpage/main_page_view_model.dart';
import 'package:band_community/presentation/login/login_view_model.dart';
import 'package:band_community/presentation/profile/profile_view_model.dart';
import 'package:band_community/presentation/resetpassword/reset_password_view_model.dart';
import 'package:band_community/presentation/signup/signup_screen_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/repository/auth_repository_impl.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/use_case/auth/check_user_name_exists_use_case.dart';
import '../domain/use_case/auth/sign_up_use_case.dart';

final getIt = GetIt.instance;

void diSetup() {
  // Supabase client
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // Repositories
  getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl(client: getIt<SupabaseClient>()));

  // UseCases
  getIt.registerFactory(() => SignUpUseCase(getIt<AuthRepository>()));
  getIt.registerFactory(() => SignInUseCase(getIt<AuthRepository>()));
  getIt.registerFactory(() => CheckUserNameExistsUseCase(getIt<AuthRepository>()));
  getIt.registerFactory(() => SignInWithKakaoUseCase(getIt<AuthRepository>()));

  // ViewModels
  getIt.registerFactory(() => SignUpViewModel(
    signUpUseCase: getIt<SignUpUseCase>(),
    signInUseCase: getIt<SignInUseCase>(),
    checkUserNameExistsUseCase: getIt<CheckUserNameExistsUseCase>(),
  ));
  getIt.registerFactory(() => LoginViewModel(
      signInUseCase: getIt<SignInUseCase>(),
      signInWithKakaoUseCase: getIt<SignInWithKakaoUseCase>()
  ));
  getIt.registerFactory(() => ResetPasswordViewModel());
  getIt.registerFactory(() => SignUpProfileViewModel());
  getIt.registerFactory(() => MainViewModel());
}
