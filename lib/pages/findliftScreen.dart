import 'package:flutter/material.dart';
import 'package:lifts_app/components/cards/availableLiftCard.dart';
import 'package:lifts_app/components/customSearchBar.dart';
import 'package:lifts_app/constants.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:provider/provider.dart';

class FindLiftScreen extends StatefulWidget {
  const FindLiftScreen({super.key});

  @override
  State<FindLiftScreen> createState() => _FindLiftScreenState();
}

class _FindLiftScreenState extends State<FindLiftScreen> {
  String? toAddress;
  String? fromAddress;
  @override
  Widget build(BuildContext context) {
    return  Consumer<LiftsViewModel>(
      builder: (context, liftsModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBarOne(),
            const SizedBox(
              height: 20,
            ),
            CustomSearchBar(
              hintText: toAddress==null?"Where are we going?":"To: ${toAddress.toString()}",
              onPressed: (String selected){
                setState(() {
                  selected==""?toAddress=null:toAddress=selected;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomSearchBar(hintText: fromAddress==null?"From?":"From: ${fromAddress.toString()}",onPressed: (selected){
              setState(() {
                  selected==""?fromAddress=null:fromAddress=selected;
              });

            },),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Available Lifts",
              style: kBlackHeadingStyle,
            ),
            const SizedBox(
              height: 20,
            ),
            liftsModel.items.length==0?Text("No lifts available."):Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: liftsModel.items.length,
                  itemBuilder: (BuildContext context, int index){
                    return AvailableLiftCard(address: liftsModel.items[index].toAddress.reference!, time:liftsModel.items[index].departureDateTime.toString() );

                  }),
            )
          ],
        );
      }
    );
  }
}
