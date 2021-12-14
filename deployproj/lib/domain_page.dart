import 'package:deployproj/main.dart';
import 'package:deployproj/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:deployproj/helper/color.dart';
import 'package:deployproj/helper/m_fonts.dart';
import 'package:deployproj/model/domain_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deployproj/home_page.dart';

class DomainPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  DomainPage({Key key, this.model}) : super(key: key);
  final DomainModel model;
  List<DomainModel> list = [
    DomainModel(name: "HEALTH", icon: Icons.favorite),
    DomainModel(name: "ENTERTAINMENT", icon: Icons.audiotrack),
    DomainModel(name: "EDUCATION", icon: Icons.book),
    DomainModel(name: "LIFESTYLE", icon: Icons.apps),
  ];

  Widget _cards(context, DomainModel model, int n) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage(n: n)));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                model.icon,
                size: 45,
                color: Colors.blue,
              ),
              title: Text(
                model.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Icon(MIcons.keyboard_arrow_left),
              ),
            ),
            Spacer(),
            // new Text("Welcome "+ _auth.loggedInUser()),
            OutlinedButton.icon(
              onPressed: () async {
                await _auth.logOut();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Logged out successfully.!"),
                ));
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new MyHomePage()));
              },
              icon: Icon(Icons.logout),
              label: Text("Logout"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(_auth.loggedInUser() + "'s Dashboard",
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: 40),
                    Text("Find Your",
                        style: GoogleFonts.inter(
                            fontSize: 22,
                            color: Colors.black87,
                            fontWeight: FontWeight.w300)),
                    Text("Perfect Mentor",
                        style: GoogleFonts.inter(
                            fontSize: 22,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: 7),
                    SizedBox(height: 25),
                    SizedBox(height: 20),
                    _cards(context, list[0], 0),
                    _cards(context, list[1], 1),
                    _cards(context, list[2], 2),
                    _cards(context, list[3], 3),
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
