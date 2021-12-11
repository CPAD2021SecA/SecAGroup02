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
        name: "Health"),
    DomainModel(
        name: "Entertainment"),
    DomainModel(
        name: "Education"),
    DomainModel(
        name: "Lifestyle"),
  ];

  Widget _category(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Featured",
                style: GoogleFonts.inter(fontSize: 14, color: Colors.black87)),
            SizedBox(
                width: 49,
                child: Divider(
                  color: MColor.green,
                  thickness: 4,
                ))
          ],
        ),
      ],
    );
  }

  Widget _cards(context, DomainModel model, int n) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(n : n)));
        },
        child: Row(
          children: <Widget>[

            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(model.name,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 15)),
                SizedBox(height: 3),
              ],
            ),
            Spacer(),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Text("Perfect Mentor",
                            style: GoogleFonts.inter(
                                fontSize: 22,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 7),

                        SizedBox(height: 25),
                        _category(context),
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