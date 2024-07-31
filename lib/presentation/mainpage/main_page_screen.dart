import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'main_page_view_model.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MainViewModel>().loadUserProfileImage());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/icons/MainIcon.svg', height: 35),
            CircleAvatar(
              radius: 20,
              backgroundImage: viewModel.userProfileImageUrl != null
                  ? NetworkImage(viewModel.userProfileImageUrl!)
                  : const AssetImage('assets/profile/Default.png')
                      as ImageProvider,
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          // 버튼이 눌렸을 때의 동작을 여기에 추가하세요.
        },
        child: Container(
          height: 56.0, // 원하는 높이
          width: 56.0, // 원하는 너비
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle, // 버튼을 둥글게 만듭니다
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text('소속된 밴드가 없어요!'),
      ),
    );
  }
}
