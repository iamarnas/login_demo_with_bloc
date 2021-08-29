import 'package:flutter/material.dart';

import '../../../../blocs/blocs.dart';

class PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);
    bool isObscure = true;

    return StreamBuilder<String>(
      stream: bloc.password,
      builder: (context, snapshot) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return TextField(
              onChanged: bloc.updatePassword,
              obscureText: isObscure,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                prefixIcon: StreamBuilder<bool?>(
                  stream: bloc.submitLogin,
                  builder: (_, snapshot) => snapshot.data == true
                      ? const Icon(Icons.lock_open_outlined)
                      : const Icon(Icons.lock_outline),
                ),
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
                errorText: snapshot.hasError ? snapshot.error.toString() : null,
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
