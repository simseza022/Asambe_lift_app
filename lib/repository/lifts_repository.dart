import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:logger/logger.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

/// Manages storing and retrieval of Lifts from Firebase
/// The idea is that you use a class like this in LiftsViewModel, instead of using FirebaseFirestore SDK directly from views
class LiftsRepository {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  var logger = Logger();


  //TODO: implement create, update and retrieve methods
  Future<Lift> addNewLift(Lift newLift) async {
    try{
      await db.collection("Lifts").add(newLift.toJson()).then((DocumentReference doc){
          print('Lift added with ID: ${doc.id}');
          newLift.setId = doc.id;
          db.collection('driverLifts')
              .doc('${user?.uid}').set({doc.id:true},SetOptions(merge: true) );

      });
      return newLift;
    }
    catch(e){
      print(e.toString());
      return newLift;
    }
  }
  Future<Map<String, dynamic>> loadLiftsData() async{
    final driverLiftsRef = db.collection("Lifts");
    try {

      QuerySnapshot docSnap = await driverLiftsRef.get();
      Map<String, dynamic> allLifts = {};
      for (var element in docSnap.docs) {allLifts[element.id]=element.data();}
      Map<String, dynamic> driverLiftsIds = await getLiftsOfferedByUser();
      List<Lift> driverLifts = [];
      List<Lift> allLiftsData = [];

      for(var id in allLifts.keys){
        Lift newLift = Lift.fromJson(allLifts[id]);
        newLift.setId = id;
        if(driverLiftsIds.containsKey(id)){
          driverLifts.add(newLift);
        }else{
          allLiftsData.add(newLift);
        }
      }
      print(allLiftsData);
      print(driverLifts);
      return {"allLifts": allLiftsData, "driverLifts": driverLifts};

    }catch(e){
      print("Error getting driverLifts doc: $e");
      return {};
    }
  }

  Future<Map<String, dynamic>> getLiftsOfferedByUser() async {
    final driverLiftsRef = db.collection("driverLifts").doc("${user?.uid}");
    try {
      DocumentSnapshot docSnap = await driverLiftsRef.get();
      if(docSnap.exists){
        return docSnap.data() as Map<String, dynamic>;
      }
    }catch(e){
      print("Error getting driverLifts doc: $e");

    }
    return {};
  }




}
