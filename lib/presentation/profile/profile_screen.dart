import 'dart:io';

import 'package:band_community/presentation/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpProfileScreen extends StatefulWidget {
  const SignUpProfileScreen({super.key});

  @override
  State<SignUpProfileScreen> createState() => _SignUpProfileScreenState();
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {
  late SignUpProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<SignUpProfileViewModel>();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '프로필 설정',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w400,
            height: 0.08,
            letterSpacing: -0.43,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 17,
            ),
            GestureDetector(
              onTap: () {
                _showBottomSheet();
              },
              child: CircleAvatar(
                radius: 45,
                backgroundImage: _viewModel.getUserImage(),
                  // onBackgroundImageError : AssetImage('assets/profile/Default.png'),
                // AssetImage('assets/profile/Default.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet() {
    return showModalBottomSheet(
        context: context,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     top: Radius.circular(25),
        //   ),
        // ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                '프로필 사진 설정',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const Divider(
                thickness: 0.2,
                color: Colors.black54,
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                  onPressed: () {
                    _viewModel.uploadImageToStorage(ImageSource.gallery);
                  },
                  child: const Text(
                    '갤러리에서 사진 선택',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  )),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 0.2,
                color: Colors.black54,
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    '사진 찍기',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  )),
              const SizedBox(
                height: 15,
              ),
            ],
          );
        });
  }
}
