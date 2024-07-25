import '../repository/profile_repository.dart';

class SaveProfileUseCase {
  final ProfileRepository repository;

  SaveProfileUseCase(this.repository);

  Future<void> execute(String userId, String introduction, String region, List<String> sessions) {
    return repository.saveProfile(userId, introduction, region, sessions);
  }
}