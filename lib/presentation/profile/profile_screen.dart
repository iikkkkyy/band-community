import 'dart:io';

import 'package:band_community/presentation/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../domain/model/profile/region_model.dart';

class SignUpProfileScreen extends StatefulWidget {
  const SignUpProfileScreen({super.key});

  @override
  State<SignUpProfileScreen> createState() => _SignUpProfileScreenState();
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {
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
                  key: const ValueKey(2),
                  controller: _introduceTextController,
                  cursorColor: Colors.grey.shade600,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    prefix: const Text(' '),
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
                  onChanged: (value) {
                    viewModel.introduction = value;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          DropdownButton<String>(
            hint: const Text("도 선택"),
            value: viewModel.selectedProvince,
            onChanged: (String? newValue) {
              if (newValue != null) {
                viewModel.selectProvince(newValue);
              }
            },
            items: viewModel.regions.map((Region region) {
              return DropdownMenuItem<String>(
                value: region.province,
                child: Text(region.province),
              );
            }).toList() as dynamic,
          ),
          if (viewModel.selectedProvince != null)
            DropdownButton<String>(
              hint: const Text("시/군/구 선택"),
              value: viewModel.selectedCity,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  viewModel.selectCity(newValue);
                }
              },
              items: viewModel.regions
                  .firstWhere((region) => region.province == viewModel.selectedProvince!)
                  .cities
                  .map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
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
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: viewModel.sessions.map((session) {
              return FilterChip(
                label: Text(session.name),
                selected: session.isSelected,
                onSelected: (bool selected) {
                  viewModel.toggleSession(session);
                },
                selectedColor: Colors.grey,
                backgroundColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              );
            }).toList(),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 115,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () async {
              await viewModel.saveProfile();
              context.go('/main');
            },
            child: const Text(
              '설정 완료',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
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
