import 'package:deployproj/main.dart';
import 'package:deployproj/service/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({ Key key }) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     appBar: AppBar(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Text("SideByGuide.com"),
            Spacer(),
            new Text("Reset Password"),
            
          ],
        ),
      
      ),
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) => value.isEmpty ? "Enter valid email ID.!" : null,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green) )
                        ),
                        
                      ),
                      SizedBox(height: 20.0),
                    
                    ],
                  ),
                ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                OutlinedButton.icon(onPressed: () async {
                            if(_formKey.currentState.validate()){
                              _auth.sendPasswordReset(email);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Please check your registered email for reset link.!"),
                                ));
                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => new MyHomePage()));
                            }
                            
                        }, icon: Icon(Icons.logout), label: Text("Send Request"), style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        
                        ),),
                OutlinedButton.icon(onPressed: () async {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => new MyHomePage()));
                            
                        }, icon: Icon(Icons.arrow_back_ios_new), label: Text("Back"), style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        
                        ),),
              ],
            ),
          ],
        ));
  }
}