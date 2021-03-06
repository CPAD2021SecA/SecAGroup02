import 'package:deployproj/chat_page.dart';
import 'package:deployproj/model/userProfile.dart';
import 'package:deployproj/service/auth.dart';
import 'package:deployproj/service/dabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deployproj/helper/constants.dart';
import 'package:deployproj/helper/m_fonts.dart';
import 'package:deployproj/model/mentor_model.dart';
import 'package:deployproj/helper/color.dart';

import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
   ProfilePage({Key key, this.profile}) : super(key: key);
  AuthService _auth = AuthService();
  final UserProfile profile;
  String queryUid = '';
  Widget _appBar(context) {
    print(profile.uid);
    print(_auth.loggedInUserID());
    // if(profile.uid.characters.characterAt(0). > _auth.loggedInUserID().characters.characterAt(0)){

    // }
    queryUid =
    DatabaseService.check(profile.uid, _auth.loggedInUserID());
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Icon(MIcons.keyboard_arrow_left),
          ),
        ),
        // Spacer(),
        // Icon(MIcons.heart_24),
      ],
    );
  }

  Widget _cards(
    context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        },
        child: Row(
          children: <Widget>[
            Container(
              height: 85,
              width: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(profile.photoUrl),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey.shade400,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: MColor.grey.withOpacity(.5)),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(MIcons.star_fill_16,
                            color: MColor.yellow, size: 15),
                        SizedBox(height: 5),
                      ],
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Reviews", style: GoogleFonts.inter(fontSize: 8)),
                        SizedBox(height: 8),
                        Text("1500",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                                color: Colors.black54)),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _description() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(profile.name,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          height: 1.3)),
                  SizedBox(height: 5),
                  Text(profile.specialist,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                          color: Colors.black54)),
                ],
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 20),
          Text("About ${profile.name.split(" ")[0]}",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600, fontSize: 15, height: 1.3)),
          SizedBox(height: 5),
          Text(profile.about,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  height: 1.4,
                  color: Colors.black54)),
        ]);
  }

  Widget _achivment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Achievements",
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600, fontSize: 15, height: 1.3)),
        SizedBox(height: 16),
        _achivmentCard(profile.ad1, profile.ah1),
        SizedBox(height: 16),
        _achivmentCard(profile.ad2, profile.ah2),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _achivmentCard(String ad, String ah) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MColor.grey.withOpacity(.1),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
            width: 40,
            alignment: Alignment.center,
            child: Icon(MIcons.star_fill_16, color: MColor.yellow)),
        title: Text(ah,
            style:
                GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15)),
        subtitle: Text(ad,
            style:
                GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 12)),
      ),
    );
  }

  Widget _button(context, query) {
    return FlatButton(
      color: MColor.blue,
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 60,
        alignment: Alignment.center,
        child: TextButton(
          child: Text(
            "Chat now",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: CupertinoColors.white),
          ),
          onPressed: () {
            print(query);
            print("nulllsss");
            print(query);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new ChatPage(name: profile.name, uid: profile.uid, queryUid: query)));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // dynamic temp;
    
    // queryUid = temp.toString();
    print("Changed");
    print(queryUid);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                _appBar(context),
                _cards(context),
                SizedBox(height: 20),
                _description(),
                SizedBox(height: 20),
                _achivment(),
                _button(context, queryUid),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
