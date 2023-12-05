import 'package:flutter/material.dart';
import 'package:lifts_app/components/cards/availableLiftCard.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/model/carsModel.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/pages/OfferLiftScreen.dart';
import 'package:lifts_app/pages/addCarScreen.dart';
import 'package:lifts_app/repository/carsRepository.dart';
import 'package:lifts_app/repository/lifts_repository.dart';
import 'package:provider/provider.dart';

import '../model/car.dart';

enum Options { addNewLift, addNewCar }

class OfferedLiftsScreen extends StatefulWidget {
  const OfferedLiftsScreen({super.key});

  @override
  State<OfferedLiftsScreen> createState() => _OfferedLiftsScreenState();
}

class _OfferedLiftsScreenState extends State<OfferedLiftsScreen> {
  double turns = 0.0;

  void _changeRotationOpen() {
    setState(() => turns += 1.0 / 8.0);
  }

  void _changeRotationClose() {
    setState(() => turns -= 1.0 / 8.0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LiftsViewModel>(builder: (context, liftsModel, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Lifts offered by you",
                style: kBlackHeadingStyle,
              ),
              Spacer(),
              MenuAnchor(
                  onOpen: _changeRotationOpen,
                  onClose: _changeRotationClose,
                  style: MenuStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => kLightScafoldBackgroundColor)),
                  builder: (context, MenuController controller, Widget? child) {
                    return AnimatedRotation(
                      turns: turns,
                      duration: const Duration(milliseconds: 400),
                      child: IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          icon: const Icon(
                            Icons.add,
                            color: kDarkOrangeColor,
                            size: 35,
                          )),
                    );
                  },
                  menuChildren: <MenuItemButton>[
                    MenuItemButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OfferLiftScreen()));
                      },
                      child: const Text(
                        "Add new lift",
                        style: TextStyle(color: kDarkColor),
                      ),
                    ),
                    MenuItemButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddCarScreen()));
                        },
                        child: Text("Add a car",
                            style: TextStyle(color: kDarkColor))),
                  ])
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          liftsModel.offeredLifts.length == 0
              ? Text("You have not offered any lifts")
              : Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: liftsModel.offeredLifts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AvailableLiftCard(
                          lift: liftsModel.offeredLifts[index],
                            address: liftsModel
                                .offeredLifts[index].toAddress.reference!,
                            time: liftsModel
                                .offeredLifts[index].departureDateTime
                                .toString());
                      }),
                )
        ],
      );
    });
  }
}
