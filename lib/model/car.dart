class Car{
  String? _id;
  String manufacturer;
  String model;
  String numberPlate;
  int totalNoPassengers;


  Car({required this.manufacturer,required this.model, required this.numberPlate, required this.totalNoPassengers});

   set setId(String? idParam) {
    _id = idParam!;
  }
  String? get getId => _id;

  Car.fromJson(Map<Object?, Object?> jsonMap ) : this(
    manufacturer: jsonMap['manufacturer'] as String,
    model: jsonMap['model'] as String,
    numberPlate: jsonMap['numberPlate'] as String,
    totalNoPassengers: jsonMap['totalNoPassengers'] as int,);


  Map<String, Object?> toJson() {
    return {
      'manufacturer': manufacturer,
      'model': model,
      'numberPlate': numberPlate,
      'totalNoPassengers': totalNoPassengers
    };
  }

  @override
  String toString() {
    return 'Car{manufacturer: $manufacturer, model: $model, numberPlate: $numberPlate, totalNoPassengers: $totalNoPassengers}';
  }

}