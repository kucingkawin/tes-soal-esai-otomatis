class RegExpFlex {

  RegExp _regExp;

  RegExp setPattern(String pattern) {
    _regExp = RegExp(
      r"^WS{1,2}:\/\/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:56789",
      caseSensitive: false,
      multiLine: false,
    );

    return _regExp;
  }
}