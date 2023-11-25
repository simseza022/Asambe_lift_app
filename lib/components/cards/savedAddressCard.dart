import 'package:flutter/material.dart';
import 'package:lifts_app/constants.dart';

class SavedAddressCard extends StatefulWidget {
  final IconData icon;
  final String text;
  const SavedAddressCard({super.key, required this.icon, required this.text});

  @override
  State<SavedAddressCard> createState() => _SavedAddressCardState();
}

class _SavedAddressCardState extends State<SavedAddressCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: kDarkOrangeColor.withAlpha(80),
        onTap: () {

        },
        child: Ink(// used the ink widget to allow the splash to show on top.
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: kDarkColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(widget.icon, color: kLightScafoldBackgroundColor, size: 48,),
              Text(widget.text, style: const TextStyle(color: kLightScafoldBackgroundColor, fontWeight: FontWeight.w500, fontSize: 16),)
            ],
          ),
        ),
      ),
    );
  }
}
