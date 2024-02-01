import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class SignUpProfileViewModel extends ChangeNotifier {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  late XFile _image;
  String? _userImageUrl;

  ImageProvider<Object>? getUserImage() {
    if (_userImageUrl != null) {
      return const NetworkImage('url');
    } else {
      return const AssetImage('assets/profile/Default.png');
    }
  }

  XFile get image => _image; //ImagePicker...

  void uploadImageToStorage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image == null) return;
    _image = image;
    ChangeNotifier();

    // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
    // StorageReference storageReference =
    //     _firebaseStorage.ref().child("profile/${_user.uid}");
    TaskSnapshot task = await _firebaseStorage
    .ref()
    .child('profile/1')
    .putFile(File(image.path));

    final downloadUrl = await task.ref.getDownloadURL();
    print(downloadUrl);

  }
}
