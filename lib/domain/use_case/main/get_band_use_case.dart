import '../../model/profile/band_model.dart';
import '../../repository/band_repository.dart';

class GetBandsUseCase {
  final BandRepository repository;

  GetBandsUseCase(this.repository);

  Future<List<Band>> execute(String userId) async {
    return await repository.getUserBands(userId);
  }
}
