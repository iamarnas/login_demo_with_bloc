import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'blocs.dart';

class LoginBloc extends Object with BlocBase, Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Add data to stream.
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  // Merging email and password streams.
  Stream<bool> get submitLogin => Rx.combineLatest2(email, password, _validate);

  // Change data
  Function(String) get updateEmail => _email.sink.add;
  Function(String) get updatePassword => _password.sink.add;

  @override
  void dispose() {
    _email.close();
    _password.close();
  }

  // Control if validation not have error.
  bool _validate(String e, String p) {
    if (identical(e, _email.value) && identical(p, _password.value)) {
      return true;
    } else {
      return false; // On Error return false.
    }
  }

  void submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;
    debugPrint('''
    User: $validEmail
    Password: $validPassword
    ''');
  }
}

// Single Global Instance
final loginBloc = LoginBloc();
