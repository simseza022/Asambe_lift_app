import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifts_app/constants.dart';

class AvailableLiftCard extends StatefulWidget {
  final String address;
  final String time;
  const AvailableLiftCard(
      {super.key, required this.address, required this.time});

  @override
  State<AvailableLiftCard> createState() => _AvailableLiftCardState();
}

class _AvailableLiftCardState extends State<AvailableLiftCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: (){},
        splashColor: kDarkOrangeColor.withAlpha(80),

        child: Ink(
          width: MediaQuery.of(context).size.width,
          height: 120,
          decoration: BoxDecoration(
              color: kDarkColor, borderRadius: BorderRadius.circular(10)),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.car,
                  size: 20,
                  color: kLightScafoldBackgroundColor,
                ),
                title: Text(
                  "From: ${widget.address.split(",")[0]}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: kLightScafoldBackgroundColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  maxLines: 1,
                ),
                subtitle: Text(
                  'Address: ${widget.address.split(',').sublist(1,).join(',')}\nDeparture: ${widget.time}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Color.fromRGBO(128, 164, 174, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  maxLines: 4,
                ),
              ),
              // Text(data)
            ],
          ),
        ),
      ),
    );
  }
}
