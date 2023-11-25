import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/views/signInForm.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightScafoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {Navigator.pop(context);},
                  icon: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  style: ButtonStyle(
                      iconSize: MaterialStateProperty.resolveWith((states) => 22),
                      iconColor: MaterialStateProperty.resolveWith(
                          (states) => kLightScafoldBackgroundColor),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.black)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Login Here",
                  style: kBlackHeadingStyle,
                ),
                const Text(
                  "Sign in to your account",
                  style:  kLightOrangeNormalTextStyle,
                ),
                const SizedBox(
                  height: 40,
                ),
                const SignInForm(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                                fontWeight: FontWeight.w500)),
                        TextSpan(
                            text: "Register",
                            style: const TextStyle(
                                color: Color.fromRGBO(49, 60, 42, 1),
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()), (route)=>false);
                              Navigator.popAndPushNamed(context, '/signUp');
                            }),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
