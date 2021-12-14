import 'package:deployproj/domain_page.dart';
import 'package:deployproj/service/auth.dart';
import 'package:deployproj/service/dabase.dart';
import 'package:deployproj/updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class SelectionScreen extends StatefulWidget {
  // const SelectionScreen({ Key? key }) : super(key: key);

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  String dropdownValue = "SELECT YOUR ROLE";
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
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
                
                Text("YOUR ROLE",
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
                      validator: (value) => value == 'SELECT YOUR ROLE' ? 'Enter valid Domain' : null,
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
                      items: <String>['SELECT YOUR ROLE','MENTOR', 'MENTEE'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10.0),
                    
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
                                if(dropdownValue == 'MENTOR'){
                                  dynamic res = await DatabaseService(uid: _auth.loggedInUserID()).checkDocumentExist(_auth.loggedInUserID());
                                if(res == null || !res.exists){
                                  Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new ProfileUpdate()));
                                }
                                else{
                                  Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new DomainPage()));
                                }
                                }
                                else{
                                  Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new DomainPage()));
                                }
                              }
                                
                            },
                            child: Center(
                              child: Text(
                                'PROCEED',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20.0),
                    
                  ],
                )),
          ),
        ])));
  }
}