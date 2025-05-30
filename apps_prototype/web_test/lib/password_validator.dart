class PasswordValidator {
  static final _pattern = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@?!_-])[A-Za-z\d@?!_-]{8,20}$'
  );

  static bool isValid(String password) {
    return _pattern.hasMatch(password);
  }

  static String? getError(String password) {
    if (password.isEmpty) return 'パスワードを入力してください';
    if (password.length < 8 || password.length > 20) return '8〜20文字で入力してください';
    if (!RegExp(r'[a-z]').hasMatch(password)) return '小文字を含めてください';
    if (!RegExp(r'[A-Z]').hasMatch(password)) return '大文字を含めてください';
    if (!RegExp(r'\d').hasMatch(password)) return '数字を含めてください';
    if (!RegExp(r'[@?!_-]').hasMatch(password)) return '記号（@?!_-）を含めてください';
    return null;
  }
}
