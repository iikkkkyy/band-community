import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../signup/error_case/signup_validation.dart';
import '../signup/error_case/supabase_auth_error_code.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idTextController = TextEditingController();
  final _passWordTextController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 155,
              ),
              SvgPicture.asset('assets/icons/MainIcon.svg'),
              const SizedBox(
                height: 95,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  key: const ValueKey(1),
                  validator: (value) =>
                      CheckValidate().validateEmail(_emailFocus, value!),
                  controller: _idTextController,
                  cursorColor: Colors.grey.shade600,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.account_circle),
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[800], fontSize: 14),
                    hintText: '이메일을 입력하세요.',
                  ),
                  onSaved: (value) {
                    viewModel.userEmail = value!;
                  },
                  onChanged: (value) {
                    viewModel.userEmail = value;
                  },
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  focusNode: _passwordFocus,
                  key: const ValueKey(2),
                  validator: (value) =>
                      CheckValidate().validatePassword(_passwordFocus, value!),
                  controller: _passWordTextController,
                  obscureText: true,
                  cursorColor: Colors.grey.shade600,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    focusColor: Colors.black,
                    hoverColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[800], fontSize: 14),
                    hintText: '비밀번호를 입력하세요.',
                  ),
                  onSaved: (value) {
                    viewModel.userPassword = value!;
                  },
                  onChanged: (value) {
                    viewModel.userPassword = value;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  viewModel.tryValidation();
                  print('Email : ${viewModel.userEmail}');
                  print('Password : ${viewModel.userPassword}');
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          bool isValid = viewModel.tryValidation();
                          if (isValid) {
                            try {
                              await viewModel.signIn(context);
                              print('로그인 성공');
                              context.go('/main');
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('로그인 실패'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          }
                        },
                        child: Container(
                          width: 250,
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
                      )
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  print('회원가입');
                  context.go('/signup');
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
                        '이메일 회원가입',
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
              TextButton(
                onPressed: () async {
                  print('카카오 연동하기');
                  await viewModel.signInWithKakaoUseCase;
                },
                child: Container(
                  width: 358,
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xffffee500), // 여기에서 backgroundColor 지정
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(width: 1),
                  ),
                  // ShapeDecoration(
                  //   color: const Color(0xFFFFEE500),
                  //   shape: RoundedRectangleBorder(
                  //     side: const BorderSide(width: 0),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  // ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 6, // 로고가 버튼의 왼쪽 끝에서 20px 떨어지도록 위치
                        child: SvgPicture.asset(
                          'assets/logo/kakao_logo.svg', // 여기에 SVG 파일 경로를 입력
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const Center(
                        child: Text(
                          '카카오 로그인',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w200,
                            height: 1.5,
                            letterSpacing: -0.43,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.go('/reset');
                    },
                    child: const Text(
                      '비밀번호 재설정',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                        fontFamily: 'Noto Sans',
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                        letterSpacing: -0.43,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
