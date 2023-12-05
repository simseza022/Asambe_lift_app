import 'package:flutter/material.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/model/car.dart';
import 'package:lifts_app/model/carsModel.dart';
import 'package:lifts_app/repository/carsRepository.dart';
import 'package:provider/provider.dart';

import '../model/lift.dart';
import '../model/lifts_view_model.dart';
import '../repository/lifts_repository.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with TickerProviderStateMixin{
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);

    LiftsRepository liftsRepo = LiftsRepository();
    liftsRepo.loadLiftsData().then((data) async {
      updateLiftList(data['allLifts'], data['driverLifts']);
      CarsRepository carsRepo = CarsRepository();
      List<Car> carData = await carsRepo.getUserCars();
      updateCarModel(carData);
    });
    super.initState();
  }@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  void updateLiftList(List<Lift> allLifts, List<Lift> userOfferedLifts) {
    Provider.of<LiftsViewModel>(context, listen: false).addAllAvailableLifts(allLifts);
    Provider.of<LiftsViewModel>(context, listen: false).setOfferedLifts = userOfferedLifts;
  }
  void updateCarModel(List<Car> cars){
    Provider.of<CarsModel>(context, listen: false).addAll(cars);
    Navigator.popAndPushNamed(context, '/homeScreen');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(44, 51, 51, 1) ,
      body: SafeArea(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Asambe", style: kOrangeHeadingStyle),
              const Text("On to your destination!", style:  kSubHeadingStyle,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/2,
                  child: LinearProgressIndicator(
                    value: controller.value,
                    color: kDarkOrangeColor,
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
