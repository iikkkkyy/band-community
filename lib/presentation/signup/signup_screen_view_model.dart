import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  // final authentication = FirebaseAuth.instance;
  final authentication = Supabase.instance.client;

  // TODO 후에 model 생성 예정
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

  Future<bool> checkUserNameExists(String userName) async {
    final query = await authentication
        .from('user_profile')
        .select('id')
        .eq('user_name', userName)
        .limit(1);
    print(query);
    if (query.isEmpty || (query == "[]")) {
      return true;
    } else {
      return false;
    }
  }
}
