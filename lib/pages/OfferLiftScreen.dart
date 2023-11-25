import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/components/buttons/darkOrangeBtn.dart';
import 'package:lifts_app/components/customSearchBar.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
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

  DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute
    );
  }



  @override
  Widget build(BuildContext context) {
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
                        hintText: toAddress==null?"Destination":"To: ${toAddress!.reference}",
                        onPressed: (String selected){
                          setState(() {
                            selected==""?toAddress=null:toAddress=Address.fromReference(reference: selected);

                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomSearchBar(hintText: fromAddress==null?"Place of departure":"From: ${fromAddress!.reference}",onPressed: (selected){
                        setState(() {
                          selected==""?fromAddress=null:fromAddress=Address.fromReference(reference: selected);
                        });

                      },),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              // _restorableDatePickerRouteFuture.present();
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

                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(selectedDate.toString())));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => kTextFieldBackgroundColor)),
                            child: const Text(
                              "Select Date",
                              style: kLightOrangeNormalTextStyle,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                           Text(
                            selectedDate==null?"Date: Not selected":"Date: ${selectedDate.toString().split(" ")[0]}",
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
                                        (states) => kTextFieldBackgroundColor)),
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
                      const Text(
                        "Number of passengers:",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Form(
                        child: Center(
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.number,
                            // controller: emailCtrl,
                            // style: ,

                            decoration: InputDecoration(
                              // label: Text("Hye"),

                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: kDarkOrangeColor)),
                              filled: true,
                              fillColor: kTextFieldBackgroundColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DarkOrangeBtn(
                          text: "Done", onPressed: () {
                            Lift lift = Lift(
                                departureDateTime: combineDateAndTime(selectedDate!, selectedTime!),
                              toAddress: toAddress!,
                              fromAddress: fromAddress!,
                              liftCar: Car(manufacturer: "Toyota", model: "Corrolla", year: 2013, totalNoPassengers: 5, )

                            );

                            print(lift.toJson());
                            Provider.of<LiftsViewModel>(context, listen: false).add(lift);
                            // Lift newLIft = Lift.fromJson(lift.toJson());
                            // print("new lift ----->\n$newLIft");


                      }, loading: false),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
