import 'package:band_community/domain/repository/profile_repository.dart';

class GetGroupProfileImageUseCase {
  final ProfileRepository _repository;

  GetGroupProfileImageUseCase(this._repository);

  Future<String?> execute(String groupId) async {
    return await _repository.getGroupProfileImageUrl(groupId);
  }
}