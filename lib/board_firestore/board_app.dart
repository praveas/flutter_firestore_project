import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirestoreproject/board_firestore/ui/custom_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class BoardApp extends StatefulWidget {
  static const String id = "BOARDAPP";
  final AuthResult user;

  const BoardApp({Key key, this.user}) : super(key: key);
  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {

  var firestoreDb = Firestore.instance.collection("board").snapshots();
  TextEditingController nameInputController;
  TextEditingController titleInputController;
  TextEditingController descriptionInputController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameInputController = new TextEditingController();
    titleInputController = new TextEditingController();
    descriptionInputController = new TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Board"),),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showDialog(context);
      },
        child: Icon(FontAwesomeIcons.pen),),
      body: StreamBuilder(
          stream: firestoreDb,
          builder: (context, snapshot){
            if(!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
                itemCount:snapshot.data.documents.length,
                itemBuilder: (context, int index){
                  //Everything is displayed here using snapshot.data.documents[index][]
                    //return Text(snapshot.data.documents[index]['title']);
                  return CustomCard(snapshot: snapshot.data, index: index);
            });
      }
      ),
    );
  }

  //form creation with save and cancel button
  _showDialog(BuildContext context) async {
    await showDialog(context: context,
        child: AlertDialog(
          contentPadding: EdgeInsets.all(10),
          content: Column(
            children: <Widget>[
              Text("Please fill out the form."),
              Expanded(
                child: TextField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Your Name*"
                  ),
                  controller: nameInputController,
              ),),
              Expanded(
                child: TextField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Title*"
                  ),
                  controller: titleInputController,
                ),),
              Expanded(
                child: TextField(
                  autocorrect: true,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "Description"
                  ),
                  controller: descriptionInputController,
                ),)
            ],
          ),
          actions: <Widget>[
            FlatButton(onPressed: (){
              nameInputController.clear();
              titleInputController.clear();
              descriptionInputController.clear();

              Navigator.pop(context);
            },
                child: Text("Cancel")),

            FlatButton(onPressed: (){
              //adding to the FireStore collection
              if(titleInputController.text.isNotEmpty &&
              nameInputController.text.isNotEmpty && descriptionInputController.text.isNotEmpty){
                Firestore.instance.collection("board")
                    .add({
                    "name" : nameInputController.text,
                    "title" : titleInputController.text,
                    "description" : descriptionInputController.text,
                    "timestamp" : new DateTime.now()
                }).then((response){
                  print(response.documentID);
                  Navigator.pop(context);
                  nameInputController.clear();
                  titleInputController.clear();
                  descriptionInputController.clear();

                }).catchError((error) => print(error));
              }
            },
                child: Text("Save"))
          ],
        ) );
  }
}



class LoginCredentials extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginCredentials> {
  String username;
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    AuthResult user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BoardApp(user:user),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Board App"),
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
            height: 40.0,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value,
            decoration: InputDecoration(
              hintText: "Enter your Email ...",
              border:  const OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          TextField(
            autocorrect: false,
            obscureText: true,
            onChanged: (value) => password = value,
            decoration: InputDecoration(
              hintText: "Enter your Password",
              border: const OutlineInputBorder(),
            ),
          ),
          CustomButton(
            text: "Log In",
            callback: () async{
              await loginUser();
            },
          )
        ],
      ),
    );
  }
}