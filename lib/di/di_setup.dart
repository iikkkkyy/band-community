import 'package:band_community/domain/use_case/auth/sign_in_use_case.dart';
import 'package:band_community/domain/use_case/auth/sign_in_with_kakao_use_case.dart';
import 'package:band_community/domain/use_case/get_group_profile_image_use_case.dart';
import 'package:band_community/domain/use_case/main/get_band_use_case.dart';
import 'package:band_community/presentation/mainpage/main_page_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/repository/auth_repository_impl.dart';
import '../data/repository/band_create_repository_impl.dart';
import '../data/repository/band_repository_impl.dart';
import '../data/repository/profile_repository_impl.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/repository/band_create_repository.dart';
import '../domain/repository/band_repository.dart'; // BandRepository 추가
import '../domain/repository/profile_repository.dart';
import '../domain/use_case/auth/check_user_name_exists_use_case.dart';
import '../domain/use_case/auth/sign_up_use_case.dart';
import '../domain/use_case/get_regions_use_case.dart';
import '../domain/use_case/get_user_profile_image_use_case.dart';
import '../domain/use_case/main/create_band_use_case.dart';
import '../domain/use_case/save_image_use_case.dart';
import '../domain/use_case/save_profile_use_case.dart';
import '../presentation/authentication/login/login_view_model.dart';
import '../presentation/authentication/profile/profile_view_model.dart';
import '../presentation/authentication/resetpassword/reset_password_view_model.dart';
import '../presentation/authentication/signup/signup_screen_view_model.dart';
import '../presentation/mainpage/create_band/create_band_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  // Supabase client
  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // Repositories
  getIt.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(client: getIt<SupabaseClient>()));
  getIt.registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(client: getIt<SupabaseClient>()));
  getIt.registerFactory<BandCreateRepository>(
      () => BandCreateRepositoryImpl(getIt<SupabaseClient>()));
  getIt.registerFactory<BandRepository>(
      () => BandRepositoryImpl(getIt<SupabaseClient>())); // BandRepository 추가

  // UseCases
  getIt.registerFactory(() => SignUpUseCase(getIt<AuthRepository>()));
  getIt.registerFactory(() => SignInUseCase(getIt<AuthRepository>()));
  getIt.registerFactory(() => CheckUserNameExistsUseCase(getIt<AuthRepository>()));
  getIt.registerFactory(() => SignInWithKakaoUseCase(getIt<AuthRepository>()));
  getIt.registerFactory(() => SaveImageUseCase(getIt<ProfileRepository>()));
  getIt.registerFactory(() => GetRegionsUseCase(getIt<ProfileRepository>()));
  getIt.registerFactory(() => SaveProfileUseCase(getIt<ProfileRepository>()));
  getIt.registerFactory(() => GetUserProfileImageUseCase(getIt<ProfileRepository>()));
  getIt.registerFactory(() => CreateBandUseCase(getIt<BandCreateRepository>()));
  getIt.registerFactory(() => GetBandsUseCase(getIt<BandRepository>()));
  getIt.registerFactory(() => GetGroupProfileImageUseCase(getIt<ProfileRepository>())); // GetBandsUseCase 추가

  // ViewModels
  getIt.registerFactory(() => SignUpViewModel(
        signUpUseCase: getIt<SignUpUseCase>(),
        signInUseCase: getIt<SignInUseCase>(),
        checkUserNameExistsUseCase: getIt<CheckUserNameExistsUseCase>(),
      ));
  getIt.registerFactory(() => LoginViewModel(
        signInUseCase: getIt<SignInUseCase>(),
        signInWithKakaoUseCase: getIt<SignInWithKakaoUseCase>(),
      ));
  getIt.registerFactory(() => ResetPasswordViewModel());
  getIt.registerFactory(() => SignUpProfileViewModel(
        saveImageUseCase: getIt<SaveImageUseCase>(),
        getRegionsUseCase: getIt<GetRegionsUseCase>(),
        saveProfileUseCase: getIt<SaveProfileUseCase>(),
      ));
  getIt.registerFactory(() => MainViewModel(
      getIt<GetUserProfileImageUseCase>(),getIt<GetGroupProfileImageUseCase>(), getIt<GetBandsUseCase>()));

  // CreateBandViewModel에 두 개의 인자를 전달합니다.
  getIt.registerFactory(() => CreateBandViewModel(
      getIt<CreateBandUseCase>(), getIt<SaveImageUseCase>()));
}
