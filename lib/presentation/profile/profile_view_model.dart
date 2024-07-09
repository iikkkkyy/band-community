import 'dart:io' as io;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpProfileViewModel extends ChangeNotifier {
  final authentication = Supabase.instance.client;
  final formKey = GlobalKey<FormState>();
  bool vocal = true;
  bool guitar = true;
  bool bass = true;
  bool drum = true;
  bool synth = true;
  bool manager = true;
  bool etc = true;

  XFile? image = XFile('assets/profile/Default.png');
  bool imageFlag = false;

  ImageProvider<Object>? getUserImage() {
    if (image == null) return const AssetImage('assets/profile/Default.png');
    if (imageFlag) {
      ChangeNotifier();
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
    ChangeNotifier();
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

  Future<void> saveImage() async {
    await authentication.storage.from('user_profile_images').upload(
          'public/${authentication.auth.currentUser?.id}',
          File(image!.path),
          fileOptions: const FileOptions(upsert: true),
        );
  }
}
