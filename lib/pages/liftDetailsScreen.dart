import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/components/buttons/darkOrangeBtn.dart';
import 'package:lifts_app/components/cards/availableLiftCard.dart';
import 'package:lifts_app/model/car.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../model/lift.dart';

class LiftDetailsScreen extends StatefulWidget {
  const LiftDetailsScreen({super.key});

  @override
  State<LiftDetailsScreen> createState() => _LiftDetailsScreenState();
}

class _LiftDetailsScreenState extends State<LiftDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    Map<String, Lift> argument =  ModalRoute.of(context)?.settings.arguments as Map<String, Lift>;
    Lift? lift = argument['lift'];

    return Scaffold(
      backgroundColor: kLightScafoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  style: ButtonStyle(
                      iconSize:
                          MaterialStateProperty.resolveWith((states) => 22),
                      iconColor: MaterialStateProperty.resolveWith(
                          (states) => kLightScafoldBackgroundColor),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.black)),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Row(
                  children: [
                    const Text(
                      "Lift Details",
                      style: kBlackHeadingStyle,
                    ),
                    const Spacer(),
               IconButton(onPressed: (){}, icon:     const Icon(
                 Icons.edit,
                 color: kDarkOrangeColor,
               ),)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width,
                  // height: 450,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kTextFieldBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'From: ',
                                  style: kBlackHeadingStyle,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${lift?.fromAddress.reference}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: kDarkColor)),
                                  ]),
                            ),
                            const SizedBox(height: 10,),
                            RichText(
                              text:  TextSpan(
                                  text: 'To: ',
                                  style: kBlackHeadingStyle,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            '${lift?.toAddress.reference}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: kDarkColor)),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 240,
                        constraints: const BoxConstraints(maxHeight: 250),
                        decoration: const BoxDecoration(
                          color: kDarkColor,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                             ListTile(
                              leading: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              title: const Text(
                                "Sisonke Msezane",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                "Email: ${FirebaseAuth.instance.currentUser?.email}",
                                style: const TextStyle(
                                    color: Color.fromRGBO(128, 164, 174, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                maxLines: 2,
                              ),
                            ),
                            const ListTile(
                              leading: Icon(
                                Icons.car_crash_outlined,
                                color: Colors.white,
                              ),
                              title: Text("2023 Toyota Corolla",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              subtitle: Text(
                                "Total number of passengers\n"
                                "Total joined: 1/4\n"
                                "Full cost: R120 (R40 per passenger)",
                                style: TextStyle(
                                    color: Color.fromRGBO(128, 164, 174, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: RichText(
                                text: const TextSpan(
                                    text: 'Full cost: ',
                                    style: TextStyle(
                                        color: Color.fromRGBO(128, 164, 174, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'R120 (R40 per passenger)',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: kDarkOrangeColor)),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                DarkOrangeBtn(text: "Cancel Lift", onPressed: (){}, loading: false)
                // const SignInForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
