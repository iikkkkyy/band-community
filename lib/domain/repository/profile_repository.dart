import 'dart:io';

abstract class ProfileRepository {
  Future<void> saveImage(File image, String userId);
  Future<bool> checkUserNameExists(String userName);
}