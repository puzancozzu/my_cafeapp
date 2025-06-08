import 'package:flutter/material.dart';

import '../src/uiHelper/floating_action_button.dart';

class HomepageUi extends StatefulWidget {
  const HomepageUi({super.key});

  @override
  State<HomepageUi> createState() => _HomepageUiState();
}

class _HomepageUiState extends State<HomepageUi> {
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
        floatingActionButton: FloatingActionButtonUI(
            onPressed: () async{
              print('FloatingActionButton pressed Home...');
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => PurchaseOrderPageUI()),
              // );
            }),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image:AssetImage("lib/assets/images/background.png"),
                fit: BoxFit.cover
            )
          ),
            child: Text("I m home Page")
        ),
      ),
    );
  }
}
