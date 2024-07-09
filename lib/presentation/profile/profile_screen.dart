import 'dart:io';

import 'package:band_community/presentation/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpProfileScreen extends StatefulWidget {
  const SignUpProfileScreen({super.key});

  @override
  State<SignUpProfileScreen> createState() => _SignUpProfileScreenState();
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {
  final _nameTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();
  final _introduceTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpProfileViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Column(
        children: [
          Center(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 17,
                ),
                GestureDetector(
                  onTap: () async {
                    await _showBottomSheet(viewModel);
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: viewModel.getUserImage(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Text('기본 프로필',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w800,
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: const ValueKey(1),
                  controller: _nameTextController,
                  cursorColor: Colors.grey.shade600,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    prefix: Text(' '),
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[800], fontSize: 14),
                    hintText: '닉네임을 입력하세요.',
                  ),
                  onSaved: (value) {
                    // viewModel.userEmail = value!;
                  },
                  onChanged: (value) {
                    // viewModel.userEmail = value;
                  },
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  key: const ValueKey(2),
                  controller: _introduceTextController,
                  cursorColor: Colors.grey.shade600,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    prefix: Text(' '),
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[800], fontSize: 14),
                    hintText: '한줄소개를 입력하세요.',
                  ),
                  onSaved: (value) {
                    // viewModel.userPassword = value!;
                  },
                  onChanged: (value) {
                    // viewModel.userPassword = value;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          const Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Text('세션',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w800,
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 37,
                width: 67,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      viewModel.vocal = !viewModel.vocal;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        viewModel.vocal == true ? Colors.grey : Colors.black,
                  ),
                  child: const Text(
                    '🎙️보컬',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                height: 37,
                width: 67,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      viewModel.guitar = !viewModel.guitar;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        viewModel.guitar == true ? Colors.grey : Colors.black,
                  ),
                  child: const Text(
                    '🎸기타',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                height: 37,
                width: 79,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      viewModel.bass = !viewModel.bass;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        viewModel.bass == true ? Colors.grey : Colors.black,
                  ),
                  child: const Text(
                    '⛺️베이스',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                height: 37,
                width: 67,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      viewModel.drum = !viewModel.drum;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        viewModel.drum == true ? Colors.grey : Colors.black,
                  ),
                  child: const Text(
                    '🥁️드럼',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 37,
                width: 67,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      viewModel.synth = !viewModel.synth;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        viewModel.synth == true ? Colors.grey : Colors.black,
                  ),
                  child: const Text(
                    '🎹️건반',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                height: 37,
                width: 79,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      viewModel.manager = !viewModel.manager;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        viewModel.manager == true ? Colors.grey : Colors.black,
                  ),
                  child: const Text(
                    '🧑‍💼매니저',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                height: 37,
                width: 70,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      viewModel.etc = !viewModel.etc;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                    viewModel.etc == true ? Colors.grey : Colors.black,
                  ),
                  child: const Text(
                    '🎵etc.',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 115,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            onPressed: () async {
              await viewModel.saveImage();
            },
            child: const Text('설정 완료',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(SignUpProfileViewModel viewModel) {
    return showModalBottomSheet(
        context: context,
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
                  onPressed: () async {
                    await viewModel.selectImage(ImageSource.gallery);
                    context.pop();
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
