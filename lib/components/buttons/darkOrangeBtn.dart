import 'package:flutter/material.dart';
import 'package:lifts_app/constants.dart';

class DarkOrangeBtn extends StatefulWidget {
  final String text;
  final void Function() onPressed;
  final bool loading;
  const DarkOrangeBtn({
    super.key,
    required this.text,
    required this.onPressed,
    required this.loading,
  });

  @override
  State<DarkOrangeBtn> createState() => _DarkOrangeBtnState();
}

class _DarkOrangeBtnState extends State<DarkOrangeBtn> with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


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
              (states) =>  Color.fromRGBO(184, 98, 27, widget.loading?0.5:1),
            )),
        onPressed: widget.onPressed,
        child: widget.loading? CircularProgressIndicator(
          value: controller.value,
          color: Colors.black,
          // strokeWidth: ,
        ):Text(
          widget.text,
          style: const TextStyle(fontSize: 16, color: kLightScafoldBackgroundColor),
        ),
    );
  }
}
