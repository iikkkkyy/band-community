import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:band_community/domain/use_case/main/create_band_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/use_case/save_image_use_case.dart';

class CreateBandViewModel extends ChangeNotifier {
  final CreateBandUseCase createBandUseCase;
  final SaveImageUseCase saveImageUseCase;

  CreateBandViewModel(this.createBandUseCase, this.saveImageUseCase);

  XFile? image = XFile('assets/profile/Default.png');
  bool imageFlag = false;
  String bandName = '';
  String bandIntroduce = '';

  ImageProvider<Object>? getBandImage() {
    if (image == null) return const AssetImage('assets/profile/Default.png');
    if (imageFlag) {
      return FileImage(io.File(image!.path));
    } else {
      return const AssetImage('assets/profile/Default.png');
    }
  }

  Future<void> selectImage(ImageSource source) async {
    final picker = ImagePicker();
    image = await picker.pickImage(source: source);
    if (image == null) return;
    String? croppedFilePath = await _cropImage(image!);
    image = XFile(croppedFilePath!);
    imageFlag = true;
    notifyListeners();
  }

  Future<String?> _cropImage(XFile file) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 80,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return croppedFile?.path;
  }

  Future<void> saveBandImage(String groupId) async {
    if (image == null) return;
    await saveImageUseCase.execute(
        io.File(image!.path), groupId, 'group_profile_images');
  }

  Future<void> createBand() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;
    final groupId = const Uuid().v4();

    // 밴드 생성 로직
    await createBandUseCase.execute(bandName, bandIntroduce, groupId);
    // 밴드 이미지 저장
    await saveBandImage(groupId);
  }
}
