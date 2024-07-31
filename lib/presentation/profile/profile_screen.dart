import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import '../../domain/model/profile/region_model.dart';
import 'profile_view_model.dart';

class SignUpProfileScreen extends StatefulWidget {
  const SignUpProfileScreen({super.key});

  @override
  State<SignUpProfileScreen> createState() => _SignUpProfileScreenState();
}

class _SignUpProfileViewModel {
  String? selectedProvince;
  String? selectedCity;
  List<Region> regions;

  _SignUpProfileViewModel({required this.regions});
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {
  final _introduceTextController = TextEditingController();
  late _SignUpProfileViewModel _viewModel;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = context.read<SignUpProfileViewModel>();
      viewModel.loadRegions().then((_) {
        setState(() {
          _viewModel = _SignUpProfileViewModel(regions: viewModel.regions);
          _isInitialized = true;
        });
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
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
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      key: const ValueKey(2),
                      controller: _introduceTextController,
                      cursorColor: Colors.grey.shade600,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16),
                        border: InputBorder.none,
                        hintStyle:
                        TextStyle(color: Colors.grey[800], fontSize: 14),
                        hintText: '한줄소개를 입력하세요.',
                      ),
                      onChanged: (value) {
                        viewModel.introduction = value;
                      },
                    ),
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
                Text('지역 설정',
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  _showRegionSelectionModal(context, viewModel);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          _viewModel.selectedProvince != null &&
                              _viewModel.selectedCity != null
                              ? '${_viewModel.selectedProvince} ${_viewModel.selectedCity}'
                              : '지역을 선택하세요',
                          style:
                          const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
              spacing: 1.0,
              runSpacing: 2.0,
              children: viewModel.sessions.map((session) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: TextButton(
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          viewModel.toggleSession(session);
                        });
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                      session.isSelected ? Colors.black : Colors.grey,
                      minimumSize: const Size(50, 37), // 최소 높이 설정 및 최소 너비 설정
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: Text(
                      session.name,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                );
              }).toList(),
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
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () async {
              await viewModel.saveProfile();
              await viewModel.saveImage();
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

  void _showRegionSelectionModal(
      BuildContext context, SignUpProfileViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewModel.regions.length,
                      itemBuilder: (context, index) {
                        final province = viewModel.regions[index].province;
                        return ListTile(
                          title: Text(province),
                          onTap: () {
                            setState(() {
                              _viewModel.selectedProvince = province;
                              _viewModel.selectedCity = null; // Reset city selection
                              viewModel.selectProvince(province);
                            });
                          },
                          selected: _viewModel.selectedProvince == province,
                          selectedTileColor: Colors.grey.shade300,
                          selectedColor: Colors.white,
                        );
                      },
                    ),
                  ),
                  if (_viewModel.selectedProvince != null)
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: viewModel.regions
                                  .firstWhere((region) =>
                              region.province ==
                                  _viewModel.selectedProvince!)
                                  .cities
                                  .length,
                              itemBuilder: (context, index) {
                                final city = viewModel.regions
                                    .firstWhere((region) =>
                                region.province ==
                                    _viewModel.selectedProvince!)
                                    .cities[index];
                                return ListTile(
                                  title: Text(city),
                                  onTap: () {
                                    setState(() {
                                      _viewModel.selectedCity = city;
                                      viewModel.selectCity(city);
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  selected: _viewModel.selectedCity == city,
                                  selectedTileColor: Colors.grey.shade300,
                                  selectedColor: Colors.white,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      setState(() {}); // Update UI when the modal is closed
    });
  }
}
