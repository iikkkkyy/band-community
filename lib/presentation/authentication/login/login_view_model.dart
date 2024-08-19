import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/use_case/auth/sign_in_use_case.dart';
import '../../../domain/use_case/auth/sign_in_with_kakao_use_case.dart';

class LoginViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final SignInUseCase signInUseCase;
  final SignInWithKakaoUseCase signInWithKakaoUseCase;

  String userEmail = '';
  String userPassword = '';

  LoginViewModel({
    required this.signInUseCase,
    required this.signInWithKakaoUseCase,
  });

  bool tryValidation() {
    final isValid = formKey.currentState!.validate();
    print(isValid);
    if (isValid) {
      formKey.currentState!.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> signIn(BuildContext context) async {
    if (tryValidation()) {
      try {
        await signInUseCase.execute(userEmail, userPassword);
        print('로그인 성공');
        // 로그인 성공 시 추가 로직
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('로그인 실패'),
          backgroundColor: Colors.red,
        ));
        throw Exception('로그인 실패');
      }
    }
  }

  Future<void> signInWithKakao(BuildContext context) async {
    try {
      await signInWithKakaoUseCase.execute();
      print('카카오 로그인 성공');
      // 카카오 로그인 성공 시 추가 로직
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('카카오 로그인 실패'),
        backgroundColor: Colors.red,
      ));
    }
  }


}
