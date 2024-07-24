import 'package:band_community/domain/repository/user_login_repository.dart';

class SignInWithKakaoUseCase {
  final UserLoginRepository repository;

  SignInWithKakaoUseCase(this.repository);

  Future<void> execute() {
    return repository.signInWithKakao();
  }
}
