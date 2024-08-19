import 'package:band_community/domain/repository/profile_repository.dart';
import 'dart:io';

class SaveImageUseCase {
  final ProfileRepository repository;

  SaveImageUseCase(this.repository);

  Future<void> execute(File image, String userId, String bucketName) async {
    await repository.saveImage(image, userId, bucketName);
  }
}
