import 'package:deployproj/chat_page.dart';
import 'package:deployproj/chatpage.dart';
import 'package:deployproj/model/userForMessage.dart';
import 'package:deployproj/passwordreset.dart';
import 'package:deployproj/profile_page.dart';
import 'package:deployproj/selectionScreen.dart';
import 'package:deployproj/service/auth.dart';
import 'package:deployproj/service/dabase.dart';
import 'package:deployproj/updateProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'signup.dart';
import 'domain_page.dart';
import 'home_page.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  String dropdownVal = 'Mentor';
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return new MediaQuery(
                data: new MediaQueryData(),
                child: new MaterialApp(home: new ErrorWidget()));
          } else if (snapshot.hasData) {
            return new MediaQuery(
                data: new MediaQueryData(),
                child: new MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: FirebaseAuth.instance.currentUser != null
                        ? new DomainPage()
                        : new MyHomePage()));
          } else {
            return new MediaQuery(
                data: new MediaQueryData(),
                child: new MaterialApp(home: new Loading()));
          }
        });
  }
}

class Loading extends StatelessWidget {
  // const Loading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Icon(Icons.error), Text("Oops.. Something went wrong.!")],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  List<UserData> userData = <UserData>[];
  String username = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    userData = DatabaseService().getDocsForUser();
    // res = DatabaseService().checkDocumentExist(_auth.loggedInUserID());
    return new Scaffold(
        appBar: AppBar(
          title: Text("Mentizzzz"),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 110.0, 0.0, 0.0),
                    child: Text('There',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(220.0, 115.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? "Enter valid email ID.!" : null,
                      onChanged: (value) {
                        setState(() {
                          username = value;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      validator: (value) => value.length < 6
                          ? "Enter a valid password. (With 6 or more charecter)"
                          : null,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(height: 10.0),
                    
                    // SizedBox(height: 10.0),

                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(left: 20.0),
                      child: InkWell(
                        child: TextButton(
                          child: Text("Forgot Password"),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new ResetPassword()));
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blueAccent,
                        color: Colors.blue,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () async {
                            
                            if (_formKey.currentState.validate()) {
                              dynamic result =
                                  await _auth.loginWithEmailAndPassword(
                                      username, password);
                              
                              print(result);
                              if (result == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Invalid User Credentials.!"),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Login Successful.!"),
                                ));
                                dynamic res = await DatabaseService().checkDocumentExist(_auth.loggedInUserID()).then((value) {
                                  if(value == null || !value.exists){
                                    Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new DomainPage()));
                                  }
                                  else{
                                    Navigator.pop(context);
                                print("Hoo tapaythu");
                                print(userData);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new ChatsPage(usersData: userData)));
                                  }
                                });
                                // if(res == null){
                                //   Navigator.pop(context);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             new DomainPage()));
                                // }
                                // else{
                                // Navigator.pop(context);
                                // print("Hoo tapaythu");
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             new ChatsPage(usersData: userData)));
                                // }
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.blue,
                        color: Colors.white,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () async {
                            dynamic result = await _auth.googleLogin();
                            if (result == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Google signin failed.!"),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Google signin Successful.!"),
                              ));
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          new SelectionScreen()));
                              // print(_auth.loggedInUserID());
                              // dynamic res = await DatabaseService(uid: _auth.loggedInUserID()).checkDocumentExist(_auth.loggedInUserID());
                              // if(res == null || !res.exists){
                              //   print("hi");
                              //   Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => new ProfileUpdate()));
                              // }
                              // else{
                              //   print("hoo");
                              //   Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => new DomainPage()));
                              // }

                            }
                          },
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: ImageIcon(
                                    AssetImage('assets/images/facebook.png')),
                              ),
                              SizedBox(width: 10.0),
                              Center(
                                child: Text(
                                  'Log in with Google',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              )
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to our Application ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new SignupPage()));
                    // Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        )));
  }
}
