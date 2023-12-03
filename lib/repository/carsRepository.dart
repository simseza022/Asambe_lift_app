import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lifts_app/model/car.dart';




class CarsRepository{
  FirebaseDatabase database = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: "https://asambe-b2f41-default-rtdb.firebaseio.com/" );

  //TODO: implement create, update and retrieve methods
  Future<Car> addNewCar(Car newCar) async {
    try{
      DatabaseReference ref  = database.ref().child('Cars');
      DatabaseReference newChildRef = ref.push();
      await newChildRef.set(newCar.toJson()).then((value){
        newCar.setId = newChildRef.key;
        print("Successfully added a new car to the database");
        //now we link the car to the user that added it, via document 'driverCars'
        database.ref()
            .child('driverCars')
            .child('${FirebaseAuth.instance.currentUser?.uid}')
            .child('${newChildRef.key}').set(true);
      });
      return newCar;
    }
    catch(e){
      print(e.toString());
      return newCar;
    }

  }
  Future<bool> checkUserHasCars(String? id) async{
    final snapshot = await database.ref().child('driverCars/$id').get();
    return snapshot.exists;
  }

}


