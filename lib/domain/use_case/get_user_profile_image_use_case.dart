import 'package:band_community/domain/repository/profile_repository.dart';

class GetUserProfileImageUseCase {
  final ProfileRepository _repository;

  GetUserProfileImageUseCase(this._repository);

  Future<String?> execute(String userId) async {
    return await _repository.getUserProfileImageUrl(userId);
  }
}