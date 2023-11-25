import 'package:flutter/material.dart';
import 'package:lifts_app/constants.dart';

class SaveAddressCard extends StatefulWidget {
  const SaveAddressCard({super.key});

  @override
  State<SaveAddressCard> createState() => _SaveAddressCardState();
}

class _SaveAddressCardState extends State<SaveAddressCard> {
  @override
  Widget build(BuildContext context) {
    return Card(

      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: kDarkOrangeColor.withAlpha(80),
        onTap: (){},
        child: Ink(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 244, 228, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.add, color: kDarkOrangeColor, size: 56,)
        ),
      ),
    );
  }
}
