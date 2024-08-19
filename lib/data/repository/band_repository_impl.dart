import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../domain/repository/band_repository.dart';

class BandRepositoryImpl implements BandRepository {
  final SupabaseClient client;

  BandRepositoryImpl(this.client);

  @override
  Future<void> createBand(String name, String description,String groupId) async {
    final response = await client.from('groups').insert({
      'group_id': groupId,
      'group_name': name,
      'group_introduce': description,
    });
    print(response);

    final userGroupsResponse = await client.from('user_groups').insert({
      'role': 'master',
      'group_id': groupId,
      'user_id': client.auth.currentUser?.id,
    });

    print(userGroupsResponse);
  }
}
