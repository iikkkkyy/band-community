import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class SignUpProfileViewModel extends ChangeNotifier {
  late XFile _image;

  XFile get image => _image; //ImagePicker...

  void uploadImageToStorage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;
    _image = image;
    ChangeNotifier();
  }


}
