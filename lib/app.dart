import 'package:flutter/material.dart';

import './src/blocs/blocs.dart';
import './src/screens/screens.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  final routes = <String, WidgetBuilder>{
    LoginScreen.routeName: (context) => LoginScreen(),
    HomeScreen.routeName: (context) => HomeScreen(title: 'Home'),
  };
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      bloc: LoginBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Demo',
        theme: ThemeData(
          primaryColor: Colors.blue,
          buttonTheme: ButtonThemeData(height: 56),
        ),
        home: LoginScreen(), // becomes the route named '/'
        routes: routes,
      ),
    );
  }
}
