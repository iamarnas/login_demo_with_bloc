extension StringExtensions on String {
  /// Validate email with [RegExp]. Must match `name@example.co(m)`
  bool get emailValidation {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,3}))$';
    final regexp = RegExp(pattern);
    return regexp.hasMatch(this);
  }

  /// If password contains A-z, 0-9 and least 6 characters then return `true``
  /// space not allowed then return `false`
  bool get passwordValidation {
    // Password must contain A-z, 0-9 and least 6 characters
    const pattern =
        r'^(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[^\d\s:])([^\s]){6,}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(this);
  }

  /// If [String] value contains space then return `true`
  bool get containsSpace {
    const pattern = r'(?=.*[\s])';
    final regexp = RegExp(pattern);
    return regexp.hasMatch(this);
  }

  bool get containsCapitalLetter {
    const pattern = '(?=.*[A-Z])';
    final regexp = RegExp(pattern);
    return regexp.hasMatch(this);
  }

  bool get containsNumber {
    const pattern = '(?=.*[0-9])';
    final regexp = RegExp(pattern);
    return regexp.hasMatch(this);
  }

  bool get containsLeastCharacters {
    const pattern = '(?=.{6,})';
    final regexp = RegExp(pattern);
    return regexp.hasMatch(this);
  }

  bool get needNumberAndCapitalLetter {
    if (!containsCapitalLetter && !containsNumber && containsLeastCharacters) {
      return true;
    } else {
      return false;
    }
  }

  bool get needNumberToBeAdded {
    if (containsCapitalLetter && !containsNumber && containsLeastCharacters) {
      return true;
    } else {
      return false;
    }
  }

  bool get needCapitalLetterToBeAdded {
    if (!containsCapitalLetter && containsNumber && containsLeastCharacters) {
      return true;
    } else {
      return false;
    }
  }

  bool get toShort {
    if (containsCapitalLetter && containsNumber && !containsLeastCharacters) {
      return true;
    } else {
      return false;
    }
  }
}
