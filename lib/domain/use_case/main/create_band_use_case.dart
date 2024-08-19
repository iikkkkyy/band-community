import '../../repository/band_repository.dart';

class CreateBandUseCase {
  final BandRepository bandRepository;

  CreateBandUseCase(this.bandRepository);

  Future<void> execute(String name, String description, String groupId) async {
    await bandRepository.createBand(name, description,groupId);
  }
}
