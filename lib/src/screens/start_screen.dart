import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = '/start_screen';

  @override
  Widget build(BuildContext context) {
    const size = Size(double.infinity, kToolbarHeight);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 320,
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: size,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: const Text('Simple Login',
                      style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: size,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AdvancedLoginScreen.routeName);
                  },
                  child: const Text('Advanced Login',
                      style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
