import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordViewModel extends ChangeNotifier{
  final formKey = GlobalKey<FormState>();
  final authentication = FirebaseAuth.instance;

  // TODO 후에 model 생성 예정
  String userEmail = '';

  bool tryValidation() {
    final isValid = formKey.currentState!.validate();
    print(isValid);
    if(isValid) {
      formKey.currentState!.save();
      return true;
    } else {
      return false;
    }

  }
}