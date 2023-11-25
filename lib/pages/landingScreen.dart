import 'package:flutter/material.dart';
import 'package:lifts_app/components/buttons/darkOrangeBtn.dart';
import 'package:lifts_app/components/buttons/darkOutlinedBtn.dart';
import 'package:lifts_app/pages/LoginScreen.dart';
import 'package:lifts_app/pages/signUpScreen.dart';

import '../constants.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(44, 51, 51, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Asambe!", style: kOrangeHeadingStyle),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Need a lift?\nWe've got you!",
                    style: kLargeTextStyle,
                  ),
                ],
              ),
              RichText(
                text: const TextSpan(
                  text: 'Catch the\n',
                  style: kLargeTextStyle,
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Cheapest ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(184, 98, 27, 1),
                        )),
                    TextSpan(
                        text: 'lift to your Destination!\n',
                        style: kLargeTextStyle),
                    TextSpan(
                        text: 'You can negotiate the price with the driver!',
                        style: kSubHeadingStyle),
                  ],
                ),
              ),
              Column(
                children: [
                  DarkOrangeBtn(text: "Sign Up", onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                  }, loading: false,),
                  const SizedBox(height: 40,),
                  DarkOutlinedBtn(text: "Sign In", onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
