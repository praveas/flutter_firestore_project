import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirestoreproject/beer_messenger/model/Login.dart';
import 'package:flutterfirestoreproject/beer_messenger/ui/Validator.dart';
import 'package:flutterfirestoreproject/main.dart';

import 'Chat.dart';

class Registration extends StatefulWidget {
  static const String id = "REGISTRATION";
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String username;
  String email;
  String password;
  String confirm_password;



  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();


  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> registerUser() async {
    /*final AuthResult user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );*/

    if(_registerFormKey.currentState.validate()){
      if(password.toString() == confirm_password.toString()) {
        AuthResult user = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password
        );

        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Chat(
            user: user,),
        )
        );
      }else{
        showDialog(context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Error"),
                content: Text("The pawwords do not match"),
                actions: [
                  FlatButton(
                    child: Text("close"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
    }
    }


    /*try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch (e){
      print("An error occured while trying to send email verification");
      print(e.message);
    }*/


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beer Messenger"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Hero(
            tag: 'logo',
            child: Container(
              child: Image.asset("assets/images/logo.png", ),
            ),
          )
          ),
          SizedBox(
            height: 31.0,
          ),
          Form(
            key: _registerFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email*",
                    hintText: "john.doe@gmail.com",
                    border:  const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                  onChanged: (value) => email = value,
                ),
                SizedBox(
                  height: 33.0,
                ),
                TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) => password = value,
                  validator: pwdValidator,
                  decoration: InputDecoration(
                    labelText: "Password*",
                    hintText: "Enter your Password",
                    border: const OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 33.0,
                ),
                TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) => confirm_password = value,
                  validator: pwdValidator,
                  decoration: InputDecoration(
                    labelText: "Confirm Password*",
                    hintText: "Enter your Password",
                    border: const OutlineInputBorder(),
                  ),
                ),
                Positioned(
                  bottom: 23.0,
                  child: CustomButton(
                    text: "Register",
                    callback: () async{
                      await registerUser();
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 33.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Already have an account?"),
          ),
          FlatButton(
            child: Text("Login here!"),
            onPressed: () {
              Navigator.of(context).pushNamed(Login.id);
            },
          )
        ],
      ),
    );
  }
}