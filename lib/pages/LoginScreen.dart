import 'package:flutter/material.dart';
import 'package:lifts_app/constants.dart';

import '../components/signInForm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kLightScafoldBackgroundColor ,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              IconButton(
                constraints: BoxConstraints(),
                padding:EdgeInsets.zero,
                  onPressed: (){},
                  icon: Icon(Icons.arrow_back,fill: 1, ),
                style: ButtonStyle(
                  iconSize: MaterialStateProperty.resolveWith((states) => 30),
                  iconColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                  backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.black)
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Login Here", style: kBlackHeadingStyle,),
              const Text("Sign in to your account", style: TextStyle(color: kDarkOrangeColor, fontWeight: FontWeight.w500),),
              const SizedBox(height: 40,),
              const SignInForm(),

              
            ],
          ),
        ),
      ),
    );
  }
}
