import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/components/buttons/darkOrangeBtn.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/pages/homeScreen.dart';
import 'package:lifts_app/pages/loadingScreen.dart';

import '../components/customAlertDialog.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Email",
            style: kTextFieldLabelStyle,
          ),
          TextFormField(
            validator: (value){
              RegExp exp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if(value == null || value.isEmpty){
                return "Email cannot be empty";
              }
              else if(!exp.hasMatch(value)){
                return "Invalid email format";
              }

              return null;
            },
            controller: emailCtrl,
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
            validator: (value){
              if(value == null || value.isEmpty){
                return "Password cannot be empty";
              }
              else if(value.length <= 3){
                return "Password must at least be 8 characters long";
              }
              return null;
            },
            controller: passwordCtrl,
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
          Row(
            children: [
              const Spacer(),
              TextButton(
                  onPressed: () {
                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const ForgotPasswordScreen()), (route) => ;
                    Navigator.pushNamed(context, '/resetPassword');
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: kTextFieldLabelStyle,
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          DarkOrangeBtn(text: "Sign In", onPressed: () {
            if(_formKey.currentState!.validate()){
              signInUser(emailCtrl.value.text, passwordCtrl.value.text).then((value){
                if(!value){
                  showDialog(
                    context: context,
                      builder: (context) =>const CustomAlertDialog(title: "Wrong Email or Password",)
                  );
                }
                else{
                  // Navigator.popAndPushNamed(context, '/loadingScreen');
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/loadingScreen', (Route<dynamic> route) => false);
                }
                setState(() {
                  loading = false;
                });
              });
              setState(() {
                loading = true;
              });
            }
          }, loading: loading,),
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
              onPressed: () {

              },
              child:  const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.google, color: kDarkOrangeColor,),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Sign in with Google",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );



  }
  Future<bool> signInUser(String email, String password) async{
    try{
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

    }on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found') {
        return false;
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        return false;
      }
      // print("error ${e.code}");
    }catch(e){
      return false;
    }
    return true;
  }
}
