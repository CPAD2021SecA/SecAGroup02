import 'package:deployproj/model/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:deployproj/helper/constants.dart';
import 'package:deployproj/helper/m_fonts.dart';
import 'package:deployproj/model/mentor_model.dart';
import 'package:deployproj/helper/color.dart';

import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key, this.profile}) : super(key: key);
  final UserProfile profile;
  Widget _appBar(context) {
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
        Spacer(),
        Icon(MIcons.heart_24),
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
        Text("Achievments",
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

  Widget _button() {
    return FlatButton(
      color: MColor.blue,
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 60,
        alignment: Alignment.center,
        child: Text("Chat Now",
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _appBar(context),
                _cards(context),
                SizedBox(height: 20),
                _description(),
                SizedBox(height: 20),
                _achivment(),
                _button(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
