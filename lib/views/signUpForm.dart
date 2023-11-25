import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifts_app/components/buttons/darkOrangeBtn.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/pages/homeScreen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {


  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool emailExists = false;
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
            // autofocus: true,
            validator: (value){
              RegExp exp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if(value == null || value.isEmpty){
                return "Email cannot be empty";
              }
              else if(!exp.hasMatch(value)){
                return "Invalid email format";
              }
              else if(emailExists){
                return "Email already exists";
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
              else if(value.length <= 8){
                return "Password must at least be 8 characters long";
              }
              return null;
            },
            obscureText: true,
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
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Confirm password",
            style: kTextFieldLabelStyle,
          ),
          TextFormField(
            obscureText: true,
            validator: (value){
              if(value != passwordCtrl.text){
                return "Passwords must match";
              }
              return null;
            },
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
          DarkOrangeBtn(text: "Sign Up",
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  createNewUser(emailCtrl.value.text, passwordCtrl.value.text).then((value){
                    if(!value){// email-already-exists
                      setState(() {
                        loading = false;
                      });
                      emailExists = true;
                      _formKey.currentState!.validate();
                      emailExists = false;
                    }
                  });
                  setState(() {
                    loading=true;
                  });
                }
            },
            loading: loading,),
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
              ),
          )
        ],
      ),
    );
  }
  Future<bool> createNewUser(String email, String password) async{
    try{
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen())));

    }on FirebaseAuthException catch (e){
      if(e.code == 'weak-password'){
        print(e.code);
      }else if (e.code == 'email-already-in-use'){

        return false;
      }
    }catch(e){
      print("Unknown error $e");
    }
    return true;
  }
}
