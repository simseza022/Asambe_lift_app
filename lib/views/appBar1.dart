import 'package:flutter/material.dart';
import 'package:lifts_app/constants.dart';

class AppBarOne extends StatefulWidget {
  const AppBarOne({super.key});

  @override
  State<AppBarOne> createState() => _AppBarOneState();
}

class _AppBarOneState extends State<AppBarOne> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leadingWidth:
      backgroundColor: kLightScafoldBackgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.settings,
                color: kDarkColor,
                size: 41,
              )),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: CircleAvatar(
          // minRadius: 5,
          maxRadius: 5,
          backgroundColor: kDarkColor,
          child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.menu,
                color: kLightScafoldBackgroundColor,
                size: 25,
              )),
        ),
      ),
    );
  }
}
