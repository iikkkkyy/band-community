String getFireBaseErrorMessage(String code) {
  if (code.contains('user-not-found') || code.contains('user-not-found')) {
    return "이메일 혹은 비밀번호가 일치하지 않습니다.";
  } else if (code.contains('user-not-found')) {
    return "이메일 혹은 비밀번호가 일치하지 않습니다.";
  } else if (code.contains('email-already-in-use')) {
    return "이미 사용 중인 이메일입니다.";
  } else if (code.contains('weak-password')) {
    return "비밀번호는 6글자 이상이어야 합니다.";
  } else if (code.contains('network-request-failed')) {
    return "네트워크 연결에 실패 하였습니다.";
  } else if (code.contains('invalid-email')) {
    return "잘못된 이메일 형식입니다.";
  } else if (code.contains('internal-error')) {
    return "잘못된 요청입니다.";
  } else {
    print(code);
    return code;
  }
}
