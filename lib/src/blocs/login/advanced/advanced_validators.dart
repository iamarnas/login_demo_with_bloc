import 'dart:async';

import '../../../extensions/validation_api.dart';

abstract class StringValidator {
  bool isValid(String value);
  String? errorText(String value);
}

class EmailValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.emailValidation;
  }

  @override
  String? errorText(String value) {
    if (value.isEmpty) return null; // Clear error text
    if (!value.emailValidation) return 'Enter a valid email';
    return null;
  }
}

class PasswordValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.passwordValidation;
  }

  @override
  String? errorText(String value) {
    if (value.containsSpace) return 'Space not allowed';
    if (value.isEmpty) return null; // Clear error text
    if (value.needNumberAndCapitalLetter) {
      return 'One Capital Letter and Number needs to be added';
    }
    if (value.needNumberToBeAdded) return 'One Number needs to be added';
    if (value.needCapitalLetterToBeAdded) {
      return 'One Capital Letter needs to be added';
    }
    if (value.toShort) return 'Need least 6 characters';
    if (!value.passwordValidation) {
      return 'Password must contain A-z, 0-9 and least 6 characters';
    }
    return null;
  }
}

/// Email and Password valitator
class AdvancedValidators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      final StringValidator emailValidator = EmailValidator();
      if (emailValidator.isValid(email)) {
        sink.add(email);
      } else {
        final error = emailValidator.errorText(email);

        if (error != null) {
          sink.addError(error);
        }
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      final StringValidator passwordValidator = PasswordValidator();

      if (passwordValidator.isValid(password)) {
        sink.add(password);
      } else {
        final error = passwordValidator.errorText(password);

        if (error != null) {
          sink.addError(error);
        }
      }
    },
  );

  final confirmPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      final StringValidator confirmPassword = PasswordValidator();

      if (confirmPassword.isValid(password)) {
        sink.add(password);
      } else {
        final error = confirmPassword.errorText(password);

        if (error != null) {
          sink.addError(error);
        }
      }
    },
  );
}
