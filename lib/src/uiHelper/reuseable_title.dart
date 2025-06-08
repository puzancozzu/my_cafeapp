import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableListTitleUi extends StatelessWidget {
  final String title;
  final IconData icon;
  const ReusableListTitleUi({Key? key, required this.title, required this.icon}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.96,
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0,),
            child: Icon(icon,
              size: 36,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          Padding(
            padding:const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0,
            ),
            child: Text(title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 32,
                color:  const Color.fromARGB(255, 250, 247, 247),
              ),
            ),
          ),
        ],
      ),
    );
  }
}