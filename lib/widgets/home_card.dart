import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

//card to represent status in home screen

class HomeCard extends StatelessWidget {
  final String title, subtitle;
  final Widget icon;

  const HomeCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sz.width * .45,
      child: Column(
        children: [
          icon,
          SizedBox(height: 6),
          Text(
            title,
            style:
                GoogleFonts.ubuntu(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            subtitle,
            style: GoogleFonts.ubuntu(
                fontSize: 12,
                color: Theme.of(context).lightText,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
