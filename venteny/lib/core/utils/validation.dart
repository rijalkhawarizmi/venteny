
class Validation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'; // Regex email
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "email not valid";
    }
    return null;
  }


  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 8) {
      return "Password must 8 characters";
    }
    return null;
  }
}