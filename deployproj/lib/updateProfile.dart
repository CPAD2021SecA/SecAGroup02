import 'package:deployproj/main.dart';
import 'package:deployproj/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfileUpdate extends StatefulWidget {
  // const ProfileUpdate({ Key key }) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  @override
 final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String domain = '';
  String url = '';
  String specialist = '';
  String about = '';
  String desc1 = '';
  String desc2 = '';
  String head1 = '';
  String head2 = '';
  String dropdownValue = 'SELECT YOUR DOMAIN';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Mentizzzz"),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
            child: Stack(
              children: <Widget>[
                
                Text("Update Profile Info",
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    DropdownButtonFormField(
                      validator: (value) => value == 'SELECT YOUR DOMAIN' ? 'Enter valid Domain' : null,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      items: <String>['SELECT YOUR DOMAIN','HEALTH', 'ENTERTAINMENT', 'EDUCATION', 'LIFESTYLE'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                        validator: (value) =>
                            value.isEmpty ? "Enter profile photo URL" : null,
                        onChanged: (val) {
                          setState(() {
                            url = val;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'PROFILE PHOTO URL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)))),
                    SizedBox(height: 10.0),
                    TextFormField(
                        validator: (value) =>
                            value.isEmpty ? "Enter your speciality." : null,
                        onChanged: (val) {
                          setState(() {
                            specialist = val;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'SPECIALIST IN',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)))),
                    SizedBox(height: 10.0),
                    TextFormField(
                        validator: (value) => value.isEmpty
                            ? "Enter about yourself"
                            : null,
                        
                        onChanged: (val) {
                          setState(() {
                            about = val;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'ABOUT YOU',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)))),
                    SizedBox(height: 10.0),
                    TextFormField(
                        validator: (value) => value.isEmpty
                            ? "Enter your achievement heading 1"
                            : null,
                       
                        onChanged: (val) {
                          setState(() {
                            head1 = val;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'ACHIEVEMENT 1 HEADING',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)))),
                    SizedBox(height: 10.0),
                    TextFormField(
                        validator: (value) => value.isEmpty
                            ? "Enter your achievement description 1"
                            : null,
                        
                        onChanged: (val) {
                          setState(() {
                            desc1 = val;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'ACHIEVEMENT 1 DESCRIPTION',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)))),
                    
                    SizedBox(height: 10.0),
                    TextFormField(
                        validator: (value) => value.isEmpty
                            ? "Enter your achievement heading 2"
                            : null,
                       
                        onChanged: (val) {
                          setState(() {
                            head2 = val;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'ACHIEVEMENT 2 HEADING',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)))),
                    SizedBox(height: 10.0),
                    TextFormField(
                        validator: (value) => value.isEmpty
                            ? "Enter your achievement description 2"
                            : null,
                        
                        onChanged: (val) {
                          setState(() {
                            desc2 = val;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'ACHIEVEMENT 2 DESCRIPTION',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)))),
                    SizedBox(height: 20.0),
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
                                dynamic result = await _auth.updateMentorProfile(dropdownValue, 
                                url, 
                                specialist, 
                                about, 
                                head1, 
                                desc1, 
                                head2, 
                                desc2);

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("Profile updated successfully.!"),
                                  ));
                                  Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                new MyHomePage()));
                              }
                                
                            },
                            child: Center(
                              child: Text(
                                'UPDATE PROFILE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),
                    
                    
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                )),
          ),
        ])));
  }
}