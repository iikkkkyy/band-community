import 'package:band_community/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<void> execute(String email, String password) {
    return repository.signInWithEmailAndPassword(email, password);
  }
}