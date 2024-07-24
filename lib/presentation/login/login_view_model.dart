import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends ChangeNotifier{
  final formKey = GlobalKey<FormState>();
  // final _authentication = FirebaseAuth.instance;
  final authentication = Supabase.instance.client;

  // TODO 후에 model 생성 예정
  String userEmail = '';
  String userPassword = '';



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
}