import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'main_page_view_model.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  @override
  void initState(){
    super.initState();
    Future.microtask(() async {
      final viewModel = context.read<MainViewModel>();
      final userId = viewModel.authentication.auth.currentUser?.id;
      viewModel.loadUserProfileImage();
      if (userId != null) {
        await viewModel.loadUserBands(userId); // Load user's bands
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/icons/MainIcon.svg', height: 25),
            CircleAvatar(
              radius: 20,
              backgroundImage: viewModel.userProfileImageUrl != null
                  ? NetworkImage(viewModel.userProfileImageUrl!)
                  : const AssetImage('assets/profile/Default.png') as ImageProvider,
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          final result = await context.push('/main/createBand');
          if (result == true) {
            final viewModel = context.read<MainViewModel>();
            final userId = viewModel.authentication.auth.currentUser?.id;
            if (userId != null) {
              await viewModel.loadUserBands(userId); // 밴드 생성 후 데이터 로드
            }
          }
        },
        child: Container(
          height: 56.0,
          width: 56.0,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(
                '내 밴드 목록',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Expanded(
              child: viewModel.bands.isEmpty
                  ? const Center(child: Text('소속된 밴드가 없어요!'))
                  : ListView.builder(
                itemCount: viewModel.bands.length,
                itemBuilder: (context, index) {
                  final band = viewModel.bands[index];
                  return GestureDetector(
                    onTap: () {
                      print(viewModel.bands[index].id);
                    },
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      elevation: 0.15,
                      shadowColor: Colors.black.withOpacity(1.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                        leading: Container(
                          padding: const EdgeInsets.all(0.0), // 원과 이미지 사이의 패딩을 설정할 수 있습니다.
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white, // 원의 배경색을 설정할 수 있습니다.
                          ),
                          child: CircleAvatar(
                            radius: 37, // CircleAvatar의 크기 조정
                            backgroundImage: viewModel.groupProfileImageUrls.length > index && viewModel.groupProfileImageUrls[index] != ''
                                ? NetworkImage(viewModel.groupProfileImageUrls[index])
                                : const AssetImage('assets/profile/Default.png') as ImageProvider,
                          ),
                        ),
                        title: Text(
                          band.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              band.introduce,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

