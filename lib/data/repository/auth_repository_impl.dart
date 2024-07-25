import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient client;

  const AuthRepositoryImpl({
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

  @override
  Future<void> signUp(
      String email, String password, Map<String, dynamic> data) async {
    await client.auth.signUp(email: email, password: password, data: data);
  }

  @override
  Future<bool> checkUserNameExists(String userName) async {
    final query = await client
        .from('user_profile')
        .select('id')
        .eq('user_name', userName)
        .limit(1);
    return query.isEmpty || (query == "[]");
  }
}
