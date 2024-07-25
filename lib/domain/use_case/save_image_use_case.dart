import 'dart:io';

import '../repository/profile_repository.dart';

class SaveImageUseCase {
  final ProfileRepository repository;

  SaveImageUseCase(this.repository);

  Future<void> execute(File image, String userId) {
    return repository.saveImage(image, userId);
  }
}