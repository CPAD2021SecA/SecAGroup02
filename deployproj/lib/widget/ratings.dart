import 'package:flutter/material.dart';
import 'package:deployproj/helper/color.dart';
import 'package:deployproj/helper/m_fonts.dart';

class Ratings extends StatelessWidget {
  const Ratings({Key key, this.rating}) : super(key: key);
  final double rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(rating.toInt(),
              (index) => Icon(MIcons.star_fill_16, size: 12, color: MColor.yellow))
          .toList(),
    );
  }
}