import 'package:band_community/domain/repository/profile_repository.dart';

import '../model/profile/region_model.dart';

class GetRegionsUseCase {
  final ProfileRepository repository;

  GetRegionsUseCase(this.repository);

  Future<List<Region>> execute() async {
    return await repository.getRegions();
  }
}
