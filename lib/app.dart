import 'package:flutter/material.dart';

import './src/blocs/blocs.dart';
import './src/screens/screens.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      bloc: LoginBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(), // becomes the route named '/'
        routes: <String, WidgetBuilder>{
          LoginScreen.routeName: (context) => LoginScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
