import 'package:flutter/material.dart';

import '../../../../blocs/blocs.dart';

final confirmPasswordFocus = FocusNode();

class ConfimPasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AdvancedLoginBloc>(context);

    return StreamBuilder<String>(
      stream: bloc.confirm,
      builder: (context, snapshot) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return TextField(
              onChanged: bloc.updateConfirmPassword,
              focusNode: confirmPasswordFocus,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'reapit password',
                labelText: 'Confirm Password',
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
