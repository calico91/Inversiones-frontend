bool validateEmail(String email) {
  const String exp = r'^[^@]+@[^@]+\.[a-zA-Z]{2,}$';
  return RegExp(exp).hasMatch(email);
}

bool validateNumberPhone(String numberPhone) {
  const String exp = r'^\d{10}$';
  return RegExp(exp).hasMatch(numberPhone);
}
