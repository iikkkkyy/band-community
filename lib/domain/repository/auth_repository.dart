abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signInWithKakao();
  Future<void> signUp(String email, String password, Map<String, dynamic> data);
  Future<bool> checkUserNameExists(String userName);
// 다른 인증 관련 메서드들 추가 가능
}