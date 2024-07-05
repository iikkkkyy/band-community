import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SignUpProfileViewModel extends ChangeNotifier {
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final formKey = GlobalKey<FormState>();
  bool vocal = true;
  bool guitar = true;
  bool bass = true;
  bool drum = true;
  bool synth = true;
  bool manager = true;
  bool etc = true;


  XFile? image = XFile('assets/profile/Default.png');
  String? _userImageUrl;
  bool imageFlag = false;


  // ImageProvider<Object>? getUserImage() {
  //   final _user = FirebaseAuth.instance.currentUser;
  //   // return NetworkImage('https://firebasestorage.googleapis.com/v0/b/band-community.appspot.com/o/profile/${_user?.uid}');
  //   if (_userImageUrl != null) {
  //     return NetworkImage(_userImageUrl!);
  //   } else {
  //     return const AssetImage('assets/profile/Default.png');
  //   }
  // }

  ImageProvider<Object>? getUserImage() {
    if(image == null) return const AssetImage('assets/profile/Default.png');
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
    if(image == null) return null;
    String? croppedFilePath = await _cropImage(image!);
    image = XFile(croppedFilePath!);
    imageFlag = true;
    ChangeNotifier();
    // return _cropImage(image!);
    // final _user =  FirebaseAuth.instance.currentUser;
    // print(FirebaseAuth.instance.currentUser);
    // if (image == null) return;
    // _image = image;
    //
    // // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
    // // StorageReference storageReference =
    // //     _firebaseStorage.ref().child("profile/${_user.uid}");
    // TaskSnapshot task = await _firebaseStorage
    // .ref()
    // .child('profile/${_user!.uid}')
    // .putFile(File(image.path));
    //
    // final downloadUrl = await task.ref.getDownloadURL();
    // _userImageUrl = downloadUrl;
    // ChangeNotifier();
    // print(downloadUrl);
  }
  Future<String?> _cropImage(XFile file) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
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


  }
