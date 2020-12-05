import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../blocs/blocs.dart';
import '../screens/screens.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    return body(bloc);
  }

  Widget body(LoginBloc bloc) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(48, 140, 48, 16),
        children: <Widget>[
          buildEmailField(bloc),
          const SizedBox(height: 12),
          buildPasswordField(bloc),
          const SizedBox(height: 12),
          buildSubmitButton(bloc),
        ],
      ),
    );
  }

  Widget buildEmailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.updateEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'name@example.com',
            labelText: 'Email',
            errorText: snapshot.error as String,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
      },
    );
  }

  Widget buildPasswordField(LoginBloc bloc) {
    bool isObscure = true;
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return TextField(
              onChanged: bloc.updatePassword,
              obscureText: isObscure,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: isObscure
                      ? const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        )
                      : Icon(
                          Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        ),
                  onPressed: () {
                    setState(() => isObscure = !isObscure);
                  },
                ),
                hintText: 'password',
                labelText: 'Password',
                errorText: snapshot.error as String,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSubmitButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.submitLogin,
      builder: (context, snapshot) {
        return SizedBox(
          width: double.infinity,
          child: OutlineButton(
            padding: const EdgeInsets.all(0),
            disabledBorderColor: Colors.grey[300],
            borderSide: BorderSide(color: Colors.grey[600]),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onPressed: snapshot.data == false || snapshot.data == null
                ? null
                : () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const HomeScreen(title: 'Home'),
                      ),
                    );
                  },
            child: Text(
              'Login',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            // Navigator.pushNamedAndRemoveUntil(context,
            // HomeScreen.routeName, (Route<dynamic> route) => false),
          ),
        );
      },
    );
  }
}
