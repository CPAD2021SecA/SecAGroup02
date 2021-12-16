import 'package:deployproj/main.dart';
import 'package:deployproj/model/userProfile.dart';
import 'package:deployproj/service/auth.dart';
import 'package:deployproj/service/dabase.dart';
import 'package:flutter/material.dart';
import 'package:deployproj/helper/color.dart';
import 'package:deployproj/helper/m_fonts.dart';
import 'package:deployproj/model/domain_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deployproj/home_page.dart';

class DomainPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  List<UserProfile> profE = <UserProfile>[];
  List<UserProfile> profH = <UserProfile>[];
  List<UserProfile> profEd = <UserProfile>[];
  List<UserProfile> profLs = <UserProfile>[];
  List<UserProfile> prof = <UserProfile>[];
  final DatabaseService db = DatabaseService();
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
          // db.getDocs();
          switch (n) {
            case 0:
              prof = profH;
              break;
            case 1:
              prof = profE;
              break;
            case 2:
              prof = profEd;
              break;
            case 3:
              prof = profLs;
              break;
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(n: n, profileData: prof)));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              // contentPadding: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
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
    profE = DatabaseService().getDocs('ENTERTAINMENT');
    profH = DatabaseService().getDocs('HEALTH');
    profEd = DatabaseService().getDocs('EDUCATION');
    profLs = DatabaseService().getDocs('LIFESTYLE');
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Text("Mentizzzz"),
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
                    Text("Welcome " + _auth.loggedInUser() + "!",
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
                    Text("Perfect Domain",
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
