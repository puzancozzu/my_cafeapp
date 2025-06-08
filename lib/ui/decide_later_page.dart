import 'package:flutter/material.dart';

class DecideLaterPage extends StatefulWidget {
  const DecideLaterPage({super.key});

  @override
  State<DecideLaterPage> createState() => _DecideLaterPageState();
}

class _DecideLaterPageState extends State<DecideLaterPage> {
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
            child: Text("I m Decide later page")
        ),
      ),
    );
  }
}
