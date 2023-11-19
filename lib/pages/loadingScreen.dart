import 'package:flutter/material.dart';
import 'package:lifts_app/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromRGBO(44, 51, 51, 1) ,
      body: SafeArea(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Asambe", style: kOrangeHeadingStyle),
              Text("On to your destination!", style:  kSubHeadingStyle,
              )
            ],
          ),
        ),

      ),
    );
  }
}
