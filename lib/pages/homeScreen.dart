import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/pages/findliftScreen.dart';
import 'package:provider/provider.dart';

import 'offeredLiftsScreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<LiftsViewModel>(
      builder: (context, liftModel, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(

              bottom: const TabBar(
                indicatorColor: kDarkColor,
                labelColor: kDarkOrangeColor,
                tabs: [
                  Tab(icon: Icon(Icons.car_rental_sharp), text: "Find lift",),
                  Tab(icon: Icon(Icons.local_taxi_outlined),text: "Offer lift",),
                ],
              ),
              backgroundColor: kLightScafoldBackgroundColor,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.settings,
                        color: kDarkColor,
                        size: 41,
                      )),
                )
              ],
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CircleAvatar(
                  // minRadius: 5,
                  maxRadius: 5,
                  backgroundColor: kDarkColor,
                  child: IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.menu,
                        color: kLightScafoldBackgroundColor,
                        size: 25,
                      )),
                ),
              ),
            ),
            backgroundColor: kLightScafoldBackgroundColor,
            body: const TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: FindLiftScreen(),
                ),
                Padding(padding: EdgeInsets.all(20),
                  child: OfferedLiftsScreen()
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
