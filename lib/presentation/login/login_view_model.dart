import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier{
  final formKey = GlobalKey<FormState>();

  // TODO 후에 model 생성 예정
  String userEmail = '';
  String userPassword = '';

  void tryValidation() {
    print(formKey.currentState);
    final isValid = formKey.currentState!.validate();
    if(isValid) {
      formKey.currentState!.save();
    }
  }
}