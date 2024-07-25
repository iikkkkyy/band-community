import 'package:band_community/domain/repository/auth_repository.dart';

class SignInWithKakaoUseCase {
  final AuthRepository repository;

  SignInWithKakaoUseCase(this.repository);

  Future<void> execute() {
    return repository.signInWithKakao();
  }
}
