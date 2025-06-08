import 'package:flutter/material.dart';

class PendingorderPageUi extends StatefulWidget {
  const PendingorderPageUi({super.key});

  @override
  State<PendingorderPageUi> createState() => _PendingorderPageUiState();
}

class _PendingorderPageUiState extends State<PendingorderPageUi> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        // backgroundColor: const Color.fromRGBO(246, 246, 248, 1),
        // backgroundColor: const Color(0xffD8B49F),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:AssetImage("lib/assets/images/background.png"),
                    fit: BoxFit.cover
                )
            ),
            child: Text("I m Pending Order Page")
        ),
      ),
    );
  }
}
