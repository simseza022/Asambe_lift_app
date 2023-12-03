import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lifts_app/model/lift.dart';
import 'package:logger/logger.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

/// Manages storing and retrieval of Lifts from Firebase
/// The idea is that you use a class like this in LiftsViewModel, instead of using FirebaseFirestore SDK directly from views
class LiftsRepository {

  FirebaseDatabase database = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: "https://asambe-b2f41-default-rtdb.firebaseio.com/" );

  User? user = FirebaseAuth.instance.currentUser;
  var logger = Logger();

  //TODO: implement create, update and retrieve methods
  Future<Lift> addNewLift(Lift newLift) async {
    try{
      DatabaseReference ref = database.ref().child('Lifts');
      DatabaseReference newLiftRef = ref.push();
      await newLiftRef.set(newLift.toJson()).then((value){
        String? liftId = newLiftRef.key;
        newLift.setId = liftId;
        database.ref().child("driverLifts")
            .child('${user?.uid}')
            .child(liftId!).set(true);
      });

      return newLift;
      
    }
    catch(e){
      print(e.toString());
      return newLift;
    }
  }
  List<Lift> liftEventListener(Function updateNotifires){
    DatabaseReference liftsRef = database.ref('Lifts');
    List<Lift> lifts = [];
    liftsRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map;

      for(var id in data.keys){
        Lift newLift = Lift.fromJson(data[id]! as Map);
        lifts.add(newLift);
      }
      updateNotifires(lifts);

    });
    return lifts;
  }



}
