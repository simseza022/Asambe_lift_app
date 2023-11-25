import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/components/buttons/darkOrangeBtn.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/model/car.dart';

class AddCarForm extends StatefulWidget {
  const AddCarForm({super.key});

  @override
  State<AddCarForm> createState() => _AddCarFormState();
}

class _AddCarFormState extends State<AddCarForm> {
  TextEditingController modelCtrl = TextEditingController();
  TextEditingController manuCtrl = TextEditingController();
  TextEditingController yearCtrl = TextEditingController();
  TextEditingController totalNoPassengersCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODO: add text form inputs
        const Text(
          "Manufacturer",
          style: kTextFieldLabelStyle,
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Field cannot be empty";
            }
            return null;
          },
          controller: manuCtrl,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: kDarkOrangeColor)),
            filled: true,
            fillColor: kTextFieldBackgroundColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 20,),
        const Text(
          "Model",
          style: kTextFieldLabelStyle,
        ),
        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Field cannot be empty";
            }
            return null;
          },
          controller: modelCtrl,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: kDarkOrangeColor)),
            filled: true,
            fillColor: kTextFieldBackgroundColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 20,),
        const Text(
          "Year",
          style: kTextFieldLabelStyle,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (value){
            if(value == null || value.isEmpty){
              return "Field cannot be empty";
            }
            return null;
          },
          controller: yearCtrl,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: kDarkOrangeColor)),
            filled: true,
            fillColor: kTextFieldBackgroundColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 20,),
        const Text(
          "Total number of passengers",
          style: kTextFieldLabelStyle,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          validator: (value){
            if(value == null || value.isEmpty){
              return "Field cannot be empty";
            }
            return null;
          },
          controller: totalNoPassengersCtrl,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: kDarkOrangeColor)),
            filled: true,
            fillColor: kTextFieldBackgroundColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 20,),
        DarkOrangeBtn(text: "Done", onPressed: (){
          if(_formKey.currentState!.validate()){
            //save a car
            Car car = Car(manufacturer: manuCtrl.text, model: modelCtrl.text, year: int.parse(yearCtrl.text), totalNoPassengers: int.parse(totalNoPassengersCtrl.text));
            print(car.toString());
            Car next = Car.fromJson(car.toJson());
            print("next ------>$next");
          }

        }, loading: false),

      ],
    ));
  }
}
