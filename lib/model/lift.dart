
import 'package:address_search_field/address_search_field.dart';

import 'car.dart';

/// Use this class to represent a Lift
class Lift {
  String? id;
  Address toAddress;
  Address fromAddress;
  DateTime departureDateTime;
  String liftCar;


  //TODO
  String? get getId => id;
  set setId(String? liftId){
    id = liftId;
  }
  Lift({required this.departureDateTime, required this.toAddress, required this.fromAddress, required this.liftCar});

  Lift.fromJson(Map<String, dynamic> jsonMap ) : this(
      departureDateTime: DateTime.parse(jsonMap['departureDateTime'] as String),
    toAddress: Address.fromReference(reference: jsonMap['toAddress'] as String),
    fromAddress: Address.fromReference(reference: jsonMap['fromAddress'] as String),
  liftCar: jsonMap['liftCar'] as String,);


  Map<String, Object?> toJson() {
    return {
      'departureDateTime': departureDateTime.toIso8601String(),
      'toAddress': toAddress.reference,
      'fromAddress': fromAddress.reference,
      'liftCar': liftCar
    };
  }

  @override
  String toString() {
    return 'Lift{departureDateTime: $departureDateTime, toAddress: ${toAddress.reference}, fromAddress: ${fromAddress.reference}, liftCar: $liftCar}';
  }
}