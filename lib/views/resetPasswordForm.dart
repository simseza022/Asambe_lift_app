import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/components/buttons/darkOrangeBtn.dart';
import 'package:lifts_app/constants.dart';

import '../components/customAlertDialog.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  TextEditingController emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
            controller: emailCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email cannot be empty";
              }
              return null;
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: kDarkOrangeColor)),
              filled: true,
              fillColor: kTextFieldBackgroundColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          DarkOrangeBtn(
            text: "Reset Password",
            onPressed: () {
              if(_formKey.currentState!.validate()){
                  resetPassword(emailCtrl.value.text).then((value){
                    print(value);
                    showDialog(context: context, builder:  (context) =>CustomAlertDialog(title: "An link to reset your password has been sent to ${emailCtrl.value.text}.",));
                    // Navigator.pop(context);
                  });
              }
            },
            loading: false,
          ),
        ],
      ),
    );
  }
  Future<bool> resetPassword(String email) async{
    try{
      final cred = await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch (e){
      if(e.code == 'weak-password'){
        print(e.code);
      }else if (e.code == 'email-already-in-use'){

        return false;
      }
      print(e.code);
      return false;
    }catch(e){
      print("Unknown error $e");
    }
    return true;
  }
}
