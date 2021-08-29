import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../login.dart';

class LoginBloc extends LoginBase with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Add data to stream.
  @override
  Stream<String> get email => _email.stream.transform(validateEmail);
  @override
  Stream<String> get password => _password.stream.transform(validatePassword);
  // Merging email and password streams.
  @override
  Stream<bool?> get submitLogin =>
      Rx.combineLatest2(email, password, _validate);

  // Change data
  @override
  Function(String) get updateEmail => _email.sink.add;
  @override
  Function(String) get updatePassword => _password.sink.add;

  @override
  void dispose() {
    _email.close();
    _password.close();
  }

  // Control if validation not have error.
  bool? _validate(String e, String p) {
    // We only need to return the required value.
    // Return true if we have the required value otherwise null
    // to tell StreamBuilder that we have no data here.
    // If you return false, not null, StreamBuilder will think it has data.
    // In this way snapshot.hasData will work properly.
    return e == _email.value && p == _password.value ? true : null;
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
final loginBloc = LoginBloc();
