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
    Future.microtask(() =>
        context.read<MainViewModel>().loadUserProfileImage());
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
            SvgPicture.asset('assets/icons/MainIcon.svg', height: 30),
            CircleAvatar(
              radius: 20,
              backgroundImage: viewModel.userProfileImageUrl != null
                  ? NetworkImage(viewModel.userProfileImageUrl!)
                  : const AssetImage('assets/profile/Default.png') as ImageProvider,
            ),
          ],
        ),
      ),
    );
  }
}
