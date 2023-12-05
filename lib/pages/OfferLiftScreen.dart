import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/components/buttons/darkOrangeBtn.dart';
import 'package:lifts_app/components/customSearchBar.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/model/carsModel.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/pages/addCarScreen.dart';
import 'package:lifts_app/repository/lifts_repository.dart';
import 'package:provider/provider.dart';

import '../model/car.dart';

class OfferLiftScreen extends StatefulWidget {
  const OfferLiftScreen({super.key});

  @override
  State<OfferLiftScreen> createState() => _OfferLiftScreenState();
}

class _OfferLiftScreenState extends State<OfferLiftScreen> {
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  Address? toAddress;
  Address? fromAddress;
  Car? selectedCar;
  final TextEditingController carCtrl = TextEditingController();
  LiftsRepository liftsRepo = LiftsRepository();

  DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  bool validateForm() {
    return !(selectedTime == null ||
        selectedDate == null ||
        fromAddress == null ||
        fromAddress == null ||
        carCtrl.text == "");
  }

  @override
  Widget build(BuildContext context) {
    List<Car> cars = Provider.of<CarsModel>(context, listen: false).cars;
    return Consumer<CarsModel>(builder: (context, carsModel, child) {
      return Scaffold(
          appBar: AppBar(
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
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Offer a lift",
                  style: kBlackHeadingStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSearchBar(
                          hintText: toAddress == null
                              ? "Destination"
                              : "To: ${toAddress!.reference}",
                          onPressed: (String selected) {
                            setState(() {
                              selected == ""
                                  ? toAddress = null
                                  : toAddress = Address.fromReference(
                                      reference: selected);
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomSearchBar(
                          hintText: fromAddress == null
                              ? "Place of departure"
                              : "From: ${fromAddress!.reference}",
                          onPressed: (selected) {
                            setState(() {
                              selected == ""
                                  ? fromAddress = null
                                  : fromAddress = Address.fromReference(
                                      reference: selected);
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                DateTime? s = await showDatePicker(
                                  context: context,
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                  initialDate: DateTime(2023, 1, 1),
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(2024),
                                );
                                setState(() {
                                  selectedDate = s;
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) =>
                                              kTextFieldBackgroundColor)),
                              child: const Text(
                                "Select Date",
                                style: kLightOrangeNormalTextStyle,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              selectedDate == null
                                  ? "Date: Not selected"
                                  : "Date: ${selectedDate.toString().split(" ")[0]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                // print("Should show");
                                final TimeOfDay? time = await showTimePicker(
                                  // textDirection
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  initialEntryMode: TimePickerEntryMode.dial,
                                  orientation: Orientation.portrait,
                                );

                                print(time);
                                // print(selectDateBtn.child.toString();)
                                setState(() {
                                  selectedTime = time;
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) =>
                                              kTextFieldBackgroundColor)),
                              child: const Text(
                                "Select Time",
                                style: kLightOrangeNormalTextStyle,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              selectedTime == null
                                  ? "Time: Not selected"
                                  : "Time: ${selectedTime?.hour}:${selectedTime?.minute}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        carsModel.cars.isEmpty
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddCarScreen()));
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) =>
                                                kTextFieldBackgroundColor)),
                                child: const Text(
                                  "Add a car",
                                  style: kLightOrangeNormalTextStyle,
                                ),
                              )
                            : DropdownMenu<Car>(
                                width: 200,
                                controller: carCtrl,
                                onSelected: (car) {
                                  selectedCar = car;
                                },
                                // initialSelection: cars[0],
                                label: const Text("Select car"),
                                dropdownMenuEntries:
                                    cars.map<DropdownMenuEntry<Car>>((Car c) {
                                  return DropdownMenuEntry<Car>(
                                      value: c,
                                      label: "${c.manufacturer} ${c.model}",
                                      enabled: true);
                                }).toList()),
                        SizedBox(
                          height: 20,
                        ),
                        DarkOrangeBtn(
                            text: "Done",
                            onPressed: addLift,
                            loading: false),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    });
  }

  void addLift() {
    if (!validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Please make sure you have filled out the whole form!",
        style: TextStyle(color: Colors.redAccent),
      )));
    } else {
      Lift lift = Lift(
          departureDateTime: combineDateAndTime(selectedDate!, selectedTime!),
          toAddress: toAddress!,
          fromAddress: fromAddress!,
          liftCar: selectedCar!.getId.toString());

      //notify listeners
      liftsRepo.addNewLift(lift).then((value) {
        if (value.getId != null) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            "Lift added successfully.",
            style: TextStyle(color: Colors.greenAccent),
          )));
          //TODO: update LiftsViewModel
          Provider.of<LiftsViewModel>(context, listen: false).addOfferedLift(value);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            "An error has occurred, Please try again",
            style: TextStyle(color: Colors.redAccent),
          )));
        }
      });
    }
  }
}
