import 'package:flutter/material.dart';
import 'package:lifts_app/components/darkOrangeBtn.dart';
import 'package:lifts_app/constants.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
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

          DarkOrangeBtn(text: "Reset Password", onPressed: () {}),

        ],
      ),
    );
  }
}
