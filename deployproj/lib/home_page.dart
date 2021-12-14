import 'package:flutter/material.dart';
import 'package:deployproj/helper/color.dart';
import 'package:deployproj/helper/m_fonts.dart';
import 'package:deployproj/model/mentor_model.dart';
import 'package:deployproj/profile_page.dart';
import 'package:deployproj/widget/ratings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deployproj/helper/constants.dart';
import 'package:deployproj/model/domain_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.model, this.n}) : super(key: key);
  final MentorModel model;
  final int n;

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
      ],
    );
  }

  Widget _category(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Popular mentors",
                style: GoogleFonts.inter(fontSize: 14, color: Colors.black87)),
          ],
        ),
        SizedBox(width: 12),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: <Widget>[
        //     Text("Popular mentors",
        //         style: GoogleFonts.inter(fontSize: 14, color: Colors.black38)),
        //   ],
        // ),
      ],
    );
  }

  Widget _cards(context, MentorModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(model: model)));
        },
        child: Row(
          children: <Widget>[
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(model.image),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey.shade400,
                      offset: Offset(4, 4),
                    )
                  ]),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.name,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 15)),
                SizedBox(height: 5),
                Text(model.type,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                        color: Colors.black54)),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Ratings(rating: model.ratings),
                SizedBox(height: 5),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
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
                    SizedBox(height: 40),
                    _appBar(context),
                    SizedBox(height: 30),
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
                    // SizedBox(height: 7),
                    // _searchBar(context),
                    SizedBox(height: 25),
                    _category(context),
                    SizedBox(height: 20),
                    _cards(context, Constants.mentorModelList[n][0]),
                    _cards(context, Constants.mentorModelList[n][1]),
                    _cards(context, Constants.mentorModelList[n][2]),
                    _cards(context, Constants.mentorModelList[n][3]),
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
