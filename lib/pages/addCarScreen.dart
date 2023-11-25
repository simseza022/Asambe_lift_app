import 'package:flutter/material.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/views/addCarForm.dart';

import '../model/car.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  AppBar(
          backgroundColor: kLightScafoldBackgroundColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CircleAvatar(
              // minRadius: 5,
              maxRadius: 5,
              backgroundColor: kDarkColor,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: kLightScafoldBackgroundColor,
                    size: 25,
                  )),
            ),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add a car",
              style: kBlackHeadingStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: AddCarForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
