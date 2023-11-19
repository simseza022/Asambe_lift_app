import 'package:flutter/material.dart';

class DarkOrangeBtn extends StatefulWidget {
  final String text;
  final void Function() onPressed;
  const DarkOrangeBtn({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<DarkOrangeBtn> createState() => _DarkOrangeBtnState();
}

class _DarkOrangeBtnState extends State<DarkOrangeBtn> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
                    )),
            fixedSize: MaterialStateProperty.resolveWith(
                (states) => Size(MediaQuery.of(context).size.width, 61)),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => const Color.fromRGBO(184, 98, 27, 1),
            )),
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          style: const TextStyle(fontSize: 16, color: Color.fromRGBO(44, 51, 51, 1)),
        ));
  }
}
