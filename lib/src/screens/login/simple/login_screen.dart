import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../blocs/blocs.dart' show BlocProvider, LoginBloc;
import '../../home.dart';

import 'widgets/widgets.dart';

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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Login',
                      style: Theme.of(context).textTheme.headline2),
                ),
                const SizedBox(height: 16),
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

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    const size = Size(double.infinity, kToolbarHeight);

    return StreamBuilder<bool?>(
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
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeScreen.routeName,
                    (route) => false,
                  );
                  bloc.submit();
                },
          child: const Text('Login', style: TextStyle(fontSize: 20)),
        );
      },
    );
  }
}
