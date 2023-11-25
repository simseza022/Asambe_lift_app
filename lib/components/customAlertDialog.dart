import 'package:flutter/material.dart';
import 'package:lifts_app/constants.dart';

class CustomAlertDialog extends StatefulWidget {
  final String title;
  const CustomAlertDialog({super.key, required this.title});

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,

      backgroundColor: kLightScafoldBackgroundColor,
      title:  Text(widget.title, style:  kLightOrangeNormalTextStyle,),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK', style: kTextFieldLabelStyle,),
        ),
      ],
    );
  }
}
