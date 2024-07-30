bool containsUpperCaseAndSpecialChar(String input) {
  final hasUpperCase = input.contains(RegExp(r'[A-Z]'));
  final hasSpecialChar = input.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  return hasUpperCase && hasSpecialChar;
}

bool isValidEmail(String email) {
  const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final regex = RegExp(pattern);
  return regex.hasMatch(email);
}
