import 'package:band_community/domain/repository/user_login_repository.dart';

class SignInUseCase {
  final UserLoginRepository repository;

  SignInUseCase(this.repository);

  Future<void> execute(String email, String password) {
    return repository.signInWithEmailAndPassword(email, password);
  }
}