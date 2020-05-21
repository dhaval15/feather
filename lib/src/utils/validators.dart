class Validators {
  static bool emailId(String text) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(text);

  static bool password(String text) =>
      text.contains(RegExp(r'[a-zA-Z]')) &&
      text.contains(RegExp(r'[0-9]')) &&
      text.length >= 6;
}
