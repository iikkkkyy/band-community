import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../main_page_view_model.dart';
import 'create_band_view_model.dart';

class CreateBandScreen extends StatefulWidget {
  const CreateBandScreen({super.key});

  @override
  State<CreateBandScreen> createState() => _CreateBandScreenState();
}

class _CreateBandScreenState extends State<CreateBandScreen> {
  final _bandNameController = TextEditingController();
  final _bandIntroduceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CreateBandViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          '밴드 개설',
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
      body: SingleChildScrollView(
        child: Column(
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
                      backgroundImage: viewModel.getBandImage(),
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
                Text('밴드 정보',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      controller: _bandNameController,
                      cursorColor: Colors.grey.shade600,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 14,
                        ),
                        hintText: '밴드명을 입력하세요.',
                      ),
                      onChanged: (value) {
                        viewModel.bandName = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      controller: _bandIntroduceController,
                      cursorColor: Colors.grey.shade600,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 14,
                        ),
                        hintText: '밴드소개 및 목표를 입력하세요.',
                      ),
                      onChanged: (value) {
                        viewModel.bandIntroduce = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 115,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              await viewModel.createBand();
              // context.go('/main');
              Navigator.pop(context, true);
            },

            child: const Text(
              '개설하기',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(CreateBandViewModel viewModel) {
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
              '밴드 사진 설정',
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
              ),
            ),
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
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        );
      },
    );
  }
}
