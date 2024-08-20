import 'dart:io';

import '../model/profile/region_model.dart';

abstract class ProfileRepository {
  Future<void> saveImage(File image, String userId,String bucketName);
  Future<List<Region>> getRegions();
  Future<void> saveProfile(String userId, String introduction, String region, List<String> sessions);
  Future<String?> getUserProfileImageUrl(String userId);
  Future<String?> getGroupProfileImageUrl(String groupId);

}
