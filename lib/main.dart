import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:tessoal/tes.dart';

import 'login.dart';
import 'menu_utama.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Backendless.initApp("769B6C66-BEB2-E3DD-FF85-A50448820600", "B57957B1-98E5-4CE2-9EE4-EC22628B8A41", "AA5F9E8D-5AF2-4947-858A-5439F7246BD4");
  dapatkanUserLogin().then((value) {
    runApp(MyApp(user: value));
  });
}

Future<BackendlessUser> dapatkanUserLogin() async {
  BackendlessUser user = await Backendless.userService.currentUser();
  print("Current user: $user");
}

class MyApp extends StatelessWidget {

  BackendlessUser user;

  MyApp({this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: user == null ? LoginPage() : MenuUtamaPage(),
      onGenerateRoute: (RouteSettings settings) {
        if(settings.name == LoginPage.route)
          return MaterialPageRoute(builder: (context) => LoginPage());
        else if(settings.name == MenuUtamaPage.route)
          return MaterialPageRoute(builder: (context) => MenuUtamaPage());
        else if(settings.name == TesPage.route)
          return MaterialPageRoute(builder: (context) => TesPage(chapter: settings.arguments));
        else
          return null;
      },
    );
  }
}
