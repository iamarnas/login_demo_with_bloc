import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'src/blocs/blocs.dart';
import 'src/screens/screens.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      bloc: LoginBloc(),
      child: BlocProvider<AdvancedLoginBloc>(
        bloc: AdvancedLoginBloc(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Login Demo',
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.purple,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: StartScreen(), // becomes the route named '/'
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case StartScreen.routeName:
                  return MaterialPageRoute(builder: (_) => StartScreen());
                case HomeScreen.routeName:
                  return CupertinoPageRoute(builder: (_) => const HomeScreen());
                case LoginScreen.routeName:
                  return CupertinoPageRoute(
                    builder: (_) => BlocProvider<LoginBloc>(
                      bloc: LoginBloc(),
                      child: LoginScreen(),
                    ),
                  );
                case AdvancedLoginScreen.routeName:
                  return CupertinoPageRoute(
                    builder: (_) => BlocProvider<AdvancedLoginBloc>(
                      bloc: AdvancedLoginBloc(),
                      child: AdvancedLoginScreen(),
                    ),
                  );
              }
            }),
      ),
    );
  }
}
