import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/components/buttons/darkOrangeBtn.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/model/car.dart';
import 'package:lifts_app/model/carsModel.dart';
import 'package:lifts_app/repository/carsRepository.dart';
import 'package:provider/provider.dart';

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
                borderSide: const BorderSide(color: kDarkOrangeColor)),
            filled: true,
            fillColor: kTextFieldBackgroundColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 20,),
        const Text(
          "Number Plate",
          style: kTextFieldLabelStyle,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
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
        DarkOrangeBtn(text: "Done", onPressed: addCar, loading: false),
      ],
    ));
  }

  void addCar(){
    if(_formKey.currentState!.validate()){
      Car car = Car(manufacturer: manuCtrl.text, model: modelCtrl.text, numberPlate: yearCtrl.text, totalNoPassengers: int.parse(totalNoPassengersCtrl.text));
      CarsRepository carRepo = CarsRepository();
      carRepo.addNewCar(car).then((value){
        if(value.getId!=null){
          Provider.of<CarsModel>(context, listen: false).add(car);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Car added successfully.\nYou can add a new lift", style: TextStyle(color: Colors.greenAccent),)));
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An error has occurred...", style: TextStyle(color: Colors.redAccent),)));
        }
      });

    }
  }
}
