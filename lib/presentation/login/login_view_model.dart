import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier{
  final _formKey = GlobalKey<FormState>();

  // TODO 후에 model 생성 예정
  String userEmail = '';
  String userPassword = '';

  void tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if(isValid) {
      _formKey.currentState!.save();
    }
  }
}