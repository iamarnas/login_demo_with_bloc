import 'dart:async';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      // Validate email with RegExp
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,3}))$';
      RegExp regexp = new RegExp(pattern);
      if (regexp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('Enter a valid email');
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      // Advanced validate password with RegExp
      // (?=.*[A-Z]) The string must contain at least 1 uppercase alphabetical character
      // (?=.*[0-9]) The string must contain at least 1 numeric character
      // (?=.{6,}) The string must be six characters or longer
      /*
      Pattern _pattern = r'(?=.*[A-Z])(?=.*[0-9])(?=.{6,})';
      RegExp _regex = new RegExp(_pattern);
      if (_regex.hasMatch(password)) {
        sink.add(password);
      } else if (password.isEmpty) {
        sink.add('');
      } else {
        sink.addError('Password must contain A-z, 0-9 and least 6 characters');
      }
       */

      // Simple validate
      if (password.length > 7) {
        sink.add(password);
      } else {
        sink.addError('Password must be at least 8 characters');
      }
    },
  );
}
