abstract class UserLoginRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signInWithKakao();
// 다른 인증 관련 메서드들 추가 가능
}