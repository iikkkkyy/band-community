import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idTextController = TextEditingController();
  final _passWordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 393,
      height: 852,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Positioned(
            left: 110,
            top: 150,
            child: SvgPicture.asset('assets/icons/MainIcon.svg'),
          ),
          Positioned(
            top: 291,
            child: Container(
              width: 393,
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _idTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: TextStyle(color: Colors.grey[800],fontSize: 14),
                  hintText: '아이디를 입력하세요.',
                ),
              ),
            ),
          ),
          Positioned(
            top: 358,
            child: Container(
              width: 393,
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passWordTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintStyle: TextStyle(color: Colors.grey[800],fontSize: 14),
                  hintText: '비밀번호를 입력하세요.',
                ),
              ),
            ),
          ),
          Positioned(
            left: 5,
            top: 425,
            child: TextButton(
              onPressed: () {
                print('로그인');
              },
              child: Container(
                width: 358,
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '로그인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Noto Sans',
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                        letterSpacing: -0.43,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 5,
            top: 490,
            child: TextButton(
              onPressed: () {
                print('회원가입');
              },
              child: Container(
                width: 358,
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '회원가입',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Noto Sans',
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                        letterSpacing: -0.43,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 820,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 393,
                  height: 32,
                  padding: const EdgeInsets.only(bottom: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 140,
                        height: 5,
                        decoration: ShapeDecoration(
                          color: Colors.black.withOpacity(0.6000000238418579),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
