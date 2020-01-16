import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'blocs.dart';

class LoginBloc extends Object with BlocBase, Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  // Control if validation not have error
  bool _validate(String e, String p) {
    if (e == _email.value && p == _password.value) {
      return true;
    }
    return false; // On Error return false.
  }

  // Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  // Merging email and password streams
  Stream<bool> get submitLogin =>
      Rx.combineLatest2(email, password, (e, p) => _validate(e, p));
  // Change data
  Function(String) get updateEmail => _email.sink.add;
  Function(String) get updatePassword => _password.sink.add;

  void dispose() {
    _email.close();
    _password.close();
  }

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;
    print('User: $validEmail \n'
        'Password: $validPassword');
  }
}

// Single Global Instance
//final loginBloc = LoginBloc();
