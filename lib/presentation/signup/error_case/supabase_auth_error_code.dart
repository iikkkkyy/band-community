String getSupaBaseErrorMessage(String code) {
  if (code.contains('registered')) {
    return "이미 등록된 이메일입니다.";
  } else {
    print(code);
    return code;
  }
}
