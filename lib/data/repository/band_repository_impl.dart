import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/model/profile/band_model.dart';
import '../../domain/repository/band_repository.dart';

class BandRepositoryImpl implements BandRepository {
  final SupabaseClient client;

  BandRepositoryImpl(this.client);

  @override
  Future<List<Band>> getUserBands(String userId) async {
    final response = await client
        .from('user_groups')
        .select('group_id')
        .eq('user_id', userId);
    print(response.toString());
    print(response);

    final groupIds = response.map((item) => item['group_id']).toList();
    print(groupIds);

    final List<Band> bands = [];

    for (String groupId in groupIds) {
      final groupResponse = await client
          .from('groups')
          .select('group_name, group_introduce')
          .eq('group_id', groupId)
          .single();

      // final imageResponse = await client.storage
      //     .from('group_profile_images')
      //     .download('public/$groupId');

      final band = Band(
        id: groupId,
        name: groupResponse['group_name'],
        introduce: groupResponse['group_introduce'],
        // image: imageResponse, // Assuming the image data is binary
      );

      bands.add(band);
    }

    return bands;
  }
}
