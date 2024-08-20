import '../../repository/band_create_repository.dart';

class CreateBandUseCase {
  final BandCreateRepository bandRepository;

  CreateBandUseCase(this.bandRepository);

  Future<void> execute(String name, String description, String groupId) async {
    await bandRepository.createBand(name, description,groupId);
  }
}
