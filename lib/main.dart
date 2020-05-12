/*
follow
Youtube: https://www.youtube.com/watch?v=1bNME5FWWXk
Github: https://github.com/tensor-programming/chat_app_live_stream/blob/master/lib/main.dart
Good Source: https://heartbeat.fritz.ai/firebase-user-authentication-in-flutter-1635fb175675
Github: https://github.com/samsam-026/flutter-example
package for dash chat : https://pub.dev/packages/dash_chat

https://github.com/duytq94/flutter-chat-demo.git
*/





import 'package:flutter/material.dart';
import 'package:flutterfirestoreproject/login_credentials_practices/main.dart';

import 'beer_messenger/model/Chat.dart';
import 'board_firestore/board_app.dart';

import 'beer_messenger/model/Registration.dart';
import 'beer_messenger/model/Login.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Board App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      //home: MyHomePage(), //with String id we can do is shown after this line
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        Registration.id: (context) => Registration(),
        Login.id: (context) => Login(),
        Chat.id: (context) => Chat(),
        BoardApp.id: (context) => LoginCredentials(),
        GoogleLogin.id: (context) => GoogleLogin(),
      },
    );
  }
}


class MyHomePage extends StatelessWidget {
  static const String id = "HOMESCREEN";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                  tag: 'logo',
                   child: Container(
                     width: 100.0,
                     child: Image.asset("assets/images/logo.png",),
                   ),
              ),
               Text(
                  "Beer Messenger",
                  style: TextStyle(
                      fontSize: 40.0,
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          CustomButton(
            text: "Log In",
            callback: (){
              Navigator.of(context).pushNamed(Login.id);
            },
          ),
          CustomButton(
            text: "Register",
            callback: (){
              Navigator.of(context).pushNamed(Registration.id);
            },
          ),
          CustomButton(
            text: "Board App",
            callback: (){
              Navigator.of(context).pushNamed(BoardApp.id);
            },
          ),
          CustomButton(
            text: "Google Logins",
            callback: (){
              Navigator.of(context).pushNamed(GoogleLogin.id);
            },
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;

  const CustomButton({Key key, this.callback, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 6.0,
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: callback,
            minWidth: 200.0,
            height: 45.0,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}










