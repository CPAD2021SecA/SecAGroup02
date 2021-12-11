import 'package:flutter/material.dart';
import 'package:deployproj/helper/color.dart';
import 'package:deployproj/helper/m_fonts.dart';
import 'package:deployproj/model/domain_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deployproj/home_page.dart';

class DomainPage extends StatelessWidget {
  DomainPage({Key key, this.model}) : super(key: key);
  final DomainModel model;
  List<DomainModel> list = [
    DomainModel(
      name: "HEALTH",
      icon: Icons.favorite,
    ),
    DomainModel(name: "ENTERTAINMENT", icon: Icons.audiotrack),
    DomainModel(name: "EDUCATION", icon: Icons.book),
    DomainModel(name: "LIFESTYLE", icon: Icons.apps),
  ];

  // Widget _category(context) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Text("Featured",
  //               style: GoogleFonts.inter(fontSize: 14, color: Colors.black87)),
  //           SizedBox(
  //               width: 49,
  //               child: Divider(
  //                 color: MColor.green,
  //                 thickness: 4,
  //               ))
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _cards(context, DomainModel model, int n) {
    return Card(
      // padding: const EdgeInsets.symmetric(vertical: 12),
      // backgroundColor: Color(0xff00BCC0),
      // body: SafeArea(
      // color: Colors.teal[200],
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage(n: n)));
        },
        // child: Row(
        //   children: <Widget>[
        //     SizedBox(
        //       width: 100,
        //     ),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         Text(model.name,
        //             textAlign: TextAlign.center,
        //             style: GoogleFonts.inter(
        //                 fontWeight: FontWeight.w600, fontSize: 15)),
        //         SizedBox(height: 25),
        //       ],
        //     ),
        //     Spacer(),
        //   ],
        // ),

        // child: Align(
        //   alignment: Alignment.center,
        //   child: Text(
        //     model.name,
        //     style: TextStyle(
        //         height: 3,
        //         color: Colors.black,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'Montserrat',
        //         fontSize: 20),
        //   ),
        // ),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Icon(MIcons.keyboard_arrow_left),
                      ),
                    ),
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
                    // _category(context),
                    SizedBox(height: 50),
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
