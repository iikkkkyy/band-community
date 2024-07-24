import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repository/user_login_repository.dart';

class UserLoginRepositoryImpl implements UserLoginRepository {
  final SupabaseClient client;


  const UserLoginRepositoryImpl({
    required this.client,
  });

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await client.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signInWithKakao() async {
    await client.auth.signInWithOAuth(OAuthProvider.kakao);
  }


}