import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifts_app/components/darkOrangeBtn.dart';
import 'package:lifts_app/constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Email",
            style: kTextFieldLabelStyle,
          ),
          TextFormField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: kDarkOrangeColor)),
              filled: true,
              fillColor: kTextFieldBackgroundColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Password",
            style: kTextFieldLabelStyle,
          ),
          TextFormField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: kDarkOrangeColor)),
              filled: true,
              fillColor: kTextFieldBackgroundColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Confirm password",
            style: kTextFieldLabelStyle,
          ),
          TextFormField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: kDarkOrangeColor)),
              filled: true,
              fillColor: kTextFieldBackgroundColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DarkOrangeBtn(text: "Sign Up", onPressed: () {}),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => kLightScafoldBackgroundColor),
                shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Color.fromRGBO(190, 185, 185, 1)),
                      borderRadius: BorderRadius.circular(10),
                    )),
                fixedSize: MaterialStateProperty.resolveWith(
                        (states) => Size(MediaQuery.of(context).size.width, 46)),
              ),
              onPressed: () {},
              child:  const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.google, color: kDarkOrangeColor,),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Sign up with Google",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
