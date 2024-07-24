import 'package:band_community/domain/use_case/sign_in_use_case.dart';
import 'package:band_community/domain/use_case/sign_in_with_kakao_use_case.dart';
import 'package:band_community/presentation/mainpage/main_page_view_model.dart';
import 'package:band_community/presentation/login/login_view_model.dart';
import 'package:band_community/presentation/profile/profile_view_model.dart';
import 'package:band_community/presentation/resetpassword/reset_password_view_model.dart';
import 'package:band_community/presentation/signup/signup_screen_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/repository/user_login_repository_impl.dart';
import '../domain/repository/user_login_repository.dart';

final getIt = GetIt.instance;

void diSetup() {
  // Supabase client
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // Repositories
  getIt.registerFactory<UserLoginRepository>(() => UserLoginRepositoryImpl(client: getIt<SupabaseClient>()));

  // UseCases
  getIt.registerFactory(() => SignInUseCase(getIt<UserLoginRepository>()));
  getIt.registerFactory(() => SignInWithKakaoUseCase(getIt<UserLoginRepository>()));

  // ViewModels
  getIt.registerFactory(() => SignUpViewModel());
  getIt.registerFactory(() => LoginViewModel(
      signInUseCase: getIt<SignInUseCase>(),
      signInWithKakaoUseCase: getIt<SignInWithKakaoUseCase>()
  ));
  getIt.registerFactory(() => ResetPasswordViewModel());
  getIt.registerFactory(() => SignUpProfileViewModel());
  getIt.registerFactory(() => MainViewModel());
}
