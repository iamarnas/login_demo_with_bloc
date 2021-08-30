import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../blocs.dart';

class AdvancedLoginBloc extends LoginBase with AdvancedValidators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirm = BehaviorSubject<String>();

  // Add data to stream.
  @override
  Stream<String> get email => _email.stream.transform(validateEmail);
  @override
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get confirm => _confirm.stream.transform(confirmPassword);
  // Merging email and password streams.
  @override
  Stream<bool?> get submitLogin {
    return Rx.combineLatest3(email, password, confirm, _validate);
  }

  Stream<bool?> get isPasswordsEquals {
    return Rx.combineLatest2(password, confirm, _validate);
  }

  Stream<ValidateModel> get validateModel => Rx.combineLatest2(
        submitLogin,
        isPasswordsEquals,
        (bool? a, bool? b) => ValidateModel(
          hasValidFields: a,
          hasEqualsPasswords: b,
        ),
      );

  // Change data
  @override
  Function(String) get updateEmail => _email.sink.add;
  @override
  Function(String) get updatePassword => _password.sink.add;
  Function(String) get updateConfirmPassword => _confirm.sink.add;

  void confirmationPasswordError(String error) {
    _confirm.addError(error);
  }

  @override
  void dispose() {
    _email.close();
    _password.close();
    _confirm.close();
  }

  // Control if validation not have error.
  bool? _validate(String a, String b, [String? c]) {
    // We only need to return the required value.
    // Return true if we have the required value otherwise null
    // to tell StreamBuilder that we have no data here.
    // If you return false, not null, StreamBuilder will think it has data.
    // In this way snapshot.hasData will work properly.
    if (c != null) {
      // Validate confirm form fields.
      if (a == _email.value && b == _password.value && c == _confirm.value) {
        return true;
      } else {
        return null;
      }
    } else {
      // Check if passwords are equals.
      if (a == _password.value &&
          b == _confirm.value &&
          _password.value == _confirm.value) {
        return true;
      } else {
        return null;
      }
    }
  }

  void submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;
    debugPrint('''
    User: $validEmail
    Password: $validPassword''');
  }
}

// Single Global Instance
final advancedLoginBloc = AdvancedLoginBloc();

class ValidateModel {
  final bool? hasValidFields;
  final bool? hasEqualsPasswords;

  const ValidateModel({this.hasValidFields, this.hasEqualsPasswords});
}
