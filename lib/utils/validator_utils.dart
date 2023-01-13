class Validator {
  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (value.length > 15) {
      return 'Too long';
    } else {
      return null;
    }
  }

  static String? validateEmail(String value) {
    final validEmail = RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      return 'Email required';
    } else if (validEmail.hasMatch(value)) {
      return null;
    } else {
      return 'Enter a valid email';
    }
  }
}
