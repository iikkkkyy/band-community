import '../../repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<void> execute(String email, String password, Map<String, dynamic> data) {
    return repository.signUp(email, password, data);
  }
}