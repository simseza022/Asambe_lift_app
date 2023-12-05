
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:lifts_app/model/lift.dart';


///Contains the relevant lifts data for our views
class LiftsViewModel extends  ChangeNotifier {
  //TODO keep track of loaded Lifts and notify views on changes
  final List<Lift> _availableLifts = [];// all available lifts
   List<Lift> _offeredLifts = [];

  /// An unmodifiable view of the Lifts.
  UnmodifiableListView<Lift> get availableLifts => UnmodifiableListView(_availableLifts);
  UnmodifiableListView<Lift> get offeredLifts => UnmodifiableListView(_offeredLifts);

  set setOfferedLifts(List<Lift> lifts){_offeredLifts = lifts;}

  /// Adds [item] to _availableLifts. T
  void addAvailableLift(Lift item) {
    _availableLifts.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  
  void addAllAvailableLifts(List<Lift> list) {
    _availableLifts.clear();
    _availableLifts.addAll(list);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void addOfferedLift(Lift lift){
    _offeredLifts.add(lift);
    notifyListeners();
  }





}