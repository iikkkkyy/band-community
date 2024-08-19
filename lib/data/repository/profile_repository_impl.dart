import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:band_community/domain/repository/profile_repository.dart';
import 'dart:io';

import '../../domain/model/profile/region_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final SupabaseClient client;

  ProfileRepositoryImpl({required this.client});

  @override
  Future<void> saveImage(File image, String userId, String bucketName) async {
    await client.storage.from(bucketName).upload(
      'public/$userId',
      image,
      fileOptions: const FileOptions(upsert: true),
    );
  }

  @override
  Future<List<Region>> getRegions() async {
    final response = await client.from('regions').select();
    final data = response;

    final Map<String, List<String>> groupedData = {};

    for (var item in data) {
      final province = item['province'];
      final city = item['city'];

      if (groupedData.containsKey(province)) {
        groupedData[province]?.add(city);
      } else {
        groupedData[province] = [city];
      }
    }

    return groupedData.entries
        .map((entry) => Region(province: entry.key, cities: entry.value))
        .toList();
  }

  @override
  Future<void> saveProfile(String userId, String introduction, String region, List<String> sessions) async {
    await client.from('user_profile').update({
      'introduce': introduction,
      'location': region,
      'session': sessions,
    }).eq('id', userId);
  }

  @override
  Future<String?> getUserProfileImageUrl(String userId) async {
    try {
      final response = await client.storage
          .from('user_profile_images')
          .createSignedUrl('public/$userId', 60 * 60); // URL valid for 1 hour
      return response;
    } catch (error) {
      print('Error loading user profile image: $error');
      return null;
    }
  }
}
