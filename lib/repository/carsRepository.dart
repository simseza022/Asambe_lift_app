import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lifts_app/model/car.dart';




class CarsRepository{
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore db = FirebaseFirestore.instance;

  //TODO: implement create, update and retrieve methods
  Future<Car> addNewCar(Car newCar) async {
    try{
      await db.collection("Cars").add(newCar.toJson()).then((DocumentReference doc){
        print('Car added with ID: ${doc.id}');
        newCar.setId = doc.id;
        db.collection("driverCars")
            .doc('${user?.uid}').set({doc.id:true},SetOptions(merge: true));
      });
      return newCar;
    }
    catch(e){
      print(e.toString());
      return newCar;
    }

  }
  Future<List<Car>> getUserCars() async {
    final driverCarsRef = db.collection("driverCars").doc("${user?.uid}");
    try {
      DocumentSnapshot docSnap = await driverCarsRef.get();
      if(docSnap.exists){
        Map<String, dynamic> driverCarIDs = docSnap.data() as Map<String, dynamic>;
        List<Car> carList = [];
        final carRef = db.collection("Cars");
        for(var carId in driverCarIDs.keys){
          DocumentSnapshot dSnap = await carRef.doc(carId).get();
          Map<String, dynamic> carData = dSnap.data() as Map<String, dynamic>;
          carList.add(Car.fromJson(carData));
        }
        return carList;
      }
    }catch(e){
      print("Error getting driverCars doc: $e");

    }
    return [];
  }

}


