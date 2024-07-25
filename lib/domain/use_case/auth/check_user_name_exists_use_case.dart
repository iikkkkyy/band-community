import '../../repository/auth_repository.dart';

class CheckUserNameExistsUseCase {
  final AuthRepository repository;

  CheckUserNameExistsUseCase(this.repository);

  Future<bool> execute(String userName) {
    return repository.checkUserNameExists(userName);
  }
}