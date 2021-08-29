import '../bloc_provider.dart';

abstract class LoginBase extends BlocBase {
  Stream<String> get email;
  Stream<String> get password;
  Stream<bool?> get submitLogin;

  Function(String) get updateEmail;
  Function(String) get updatePassword;
}
