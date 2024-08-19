import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/use_case/auth/check_user_name_exists_use_case.dart';
import '../../../domain/use_case/auth/sign_in_use_case.dart';
import '../../../domain/use_case/auth/sign_up_use_case.dart';

class SignUpViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final CheckUserNameExistsUseCase checkUserNameExistsUseCase;

  SignUpViewModel({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.checkUserNameExistsUseCase,
  });

  String userName = '';
  String userEmail = '';
  String userPassword = '';
  String userPhone = '';

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

  Future<bool> checkUserNameExists(String userName) {
    return checkUserNameExistsUseCase.execute(userName);
  }

  Future<void> signUp(BuildContext context) async {
    if (tryValidation()) {
      bool nickNameValid = await checkUserNameExists(userName);
      if (nickNameValid) {
        try {
          await signUpUseCase.execute(userEmail, userPassword, {
            'display_name': userName,
            'user_name': userName,
            'phone': userPhone,
          });
          await signInUseCase.execute(userEmail, userPassword);
          context.go('/profile');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('중복된 닉네임입니다.'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}
