import 'package:flutter/material.dart';

class DarkOutlinedBtn extends StatefulWidget {
  final String text;
  final void Function() onPressed;
  const DarkOutlinedBtn(
      {super.key, required this.text, required this.onPressed});

  @override
  State<DarkOutlinedBtn> createState() => _DarkOutlinedBtnState();
}

class _DarkOutlinedBtnState extends State<DarkOutlinedBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
              (states) => const Color.fromRGBO(44, 51, 51, 1)),
          shape: MaterialStateProperty.resolveWith((states) =>
              RoundedRectangleBorder(
                side: const BorderSide(color: Color.fromRGBO(184, 98, 27, 1)),
                borderRadius: BorderRadius.circular(23),
              )),
          fixedSize: MaterialStateProperty.resolveWith(
              (states) => Size(MediaQuery.of(context).size.width, 61)),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ));
  }
}
