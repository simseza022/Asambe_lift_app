class Car{
  String manufacturer;
  String model;
  int year;
  int totalNoPassengers;
  Car({required this.manufacturer,required this.model, required this.year, required this.totalNoPassengers});

  Car.fromJson(Map<String, Object?> jsonMap ) : this(
    manufacturer: jsonMap['manufacturer'] as String,
    model: jsonMap['model'] as String,
    year: jsonMap['year'] as int,
    totalNoPassengers: jsonMap['totalNoPassengers'] as int,);


  Map<String, Object?> toJson() {
    return {
      'manufacturer': manufacturer,
      'model': model,
      'year': year,
      'totalNoPassengers': totalNoPassengers
    };
  }

  @override
  String toString() {
    return 'Car{manufacturer: $manufacturer, model: $model, year: $year, totalNoPassengers: $totalNoPassengers}';
  }
}