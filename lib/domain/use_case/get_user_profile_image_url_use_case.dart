import '../repository/user_repository.dart';

class GetUserProfileImageUrl {
  final UserRepository repository;

  GetUserProfileImageUrl(this.repository);

  Future<String> call(String userId) {
    return repository.getUserProfileImageUrl(userId);
  }
}
