class RegExpFlex {

  RegExp _regExp;

  RegExp setPattern(String pattern) {
    _regExp = RegExp(
      pattern,
      caseSensitive: false,
      multiLine: false,
    );

    return _regExp;
  }
}