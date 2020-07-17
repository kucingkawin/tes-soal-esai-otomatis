import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'menu_utama.dart';

class LoginPage extends StatefulWidget
{
  static String route = "login";

  LoginPage({Key key}) : super(key: key);

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}


class LoginPageState extends State<LoginPage> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
            //(left: 24.0, right: 24.0),
            controller: ScrollController(),
            shrinkWrap: true,
            children: <Widget>[
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.fromLTRB(
                        20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: _controllerPassword,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(
                    20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))
                ),
              ),
              SizedBox(height: 10.0),
              FlatButton(
                child: Text('Login'),
                color: Colors.blue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)
                ),
                onPressed: () async {
                  if (_controllerEmail.text == 'nandaprasesoft98@gmail.com' && _controllerPassword.text == '1234567890')
                    Navigator.of(context).pushReplacementNamed(MenuUtamaPage.route);
                  else {
                    AlertDialog alertDialog = AlertDialog(
                      title: Text('Kesalahan'),
                      content: Text('Email dan password tidak terdaftar.'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Baiklah'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );

                    showDialog(context: context, builder: (context) {
                      return alertDialog;
                    });
                  }
                },
              ),
            ],
          ),
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
