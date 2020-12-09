import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../blocs/blocs.dart';
import '../screens/screens.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 320,
            child: Column(
              children: [
                EmailTextField(),
                const SizedBox(height: 16),
                PasswordTextField(),
                const SizedBox(height: 16),
                SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);

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
}

class PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
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
                      ? const Icon(Icons.visibility_off, color: Colors.grey)
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
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    const size = Size(double.infinity, kToolbarHeight);

    return StreamBuilder(
      stream: bloc.submitLogin,
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: size,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: !snapshot.hasData
              ? null
              : () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
          child: const Text('Login', style: TextStyle(fontSize: 20)),
        );
      },
    );
  }
}
