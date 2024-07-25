import 'dart:io' as io;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:band_community/domain/use_case/save_image_use_case.dart';
import 'package:band_community/domain/use_case/save_profile_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/model/profile/region_model.dart';
import '../../domain/model/profile/session_model.dart';
import '../../domain/use_case/get_regions_use_case.dart';

class SignUpProfileViewModel extends ChangeNotifier {
  final SaveImageUseCase saveImageUseCase;
  final GetRegionsUseCase getRegionsUseCase;
  final SaveProfileUseCase saveProfileUseCase;
  final formKey = GlobalKey<FormState>();

  List<Sessions> sessions = [
    Sessions(name: '🎙️보컬'),
    Sessions(name: '🎸기타'),
    Sessions(name: '⛺️베이스'),
    Sessions(name: '🥁️드럼'),
    Sessions(name: '🎹️건반'),
    Sessions(name: '🧑‍💼매니저'),
    Sessions(name: '🎵etc.'),
  ];

  XFile? image = XFile('assets/profile/Default.png');
  bool imageFlag = false;

  List<Region> regions = [];
  String? selectedProvince;
  String? selectedCity;
  String introduction = '';

  SignUpProfileViewModel({
    required this.saveImageUseCase,
    required this.getRegionsUseCase,
    required this.saveProfileUseCase,
  });

  ImageProvider<Object>? getUserImage() {
    if (image == null) return const AssetImage('assets/profile/Default.png');
    if (imageFlag) {
      notifyListeners();
      return FileImage(io.File(image!.path));
    } else {
      return const AssetImage('assets/profile/Default.png');
    }
  }

  Future<void> selectImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
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

  Future<void> loadRegions() async {
    regions = await getRegionsUseCase.execute();
    notifyListeners();
  }

  void selectProvince(String province) {
    selectedProvince = province;
    selectedCity = null; // Reset city when province changes
    notifyListeners();
  }

  void selectCity(String city) {
    selectedCity = city;
    notifyListeners();
  }

  void toggleSession(Sessions sessions) {
    sessions.isSelected = !sessions.isSelected;
    notifyListeners();
  }

  Future<void> saveProfile() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId != null) {
      List<String> selectedSessions = sessions
          .where((sessions) => sessions.isSelected)
          .map((sessions) => sessions.name)
          .toList();
      final region = selectedProvince != null && selectedCity != null
          ? '$selectedProvince $selectedCity'
          : '';
      await saveProfileUseCase.execute(
          userId, introduction, region, selectedSessions);
      if (image != null) {
        await saveImageUseCase.execute(io.File(image!.path), userId);
      }
    }
  }
}
