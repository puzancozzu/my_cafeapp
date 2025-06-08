import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonUI extends StatelessWidget {
  final Future<void> Function() onPressed;
  FloatingActionButtonUI({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: const Color.fromRGBO(25, 153, 38, 1),
        shape: const CircleBorder(),
        elevation: 8,
        child: Icon(
            Icons.add_rounded,
            color: const Color.fromRGBO(255, 255, 255, 1),
            size: 30
        ),
      ),
    );
  }
}