import 'dart:collection';

import 'package:flutter/material.dart';

import 'car.dart';


class CarsModel extends ChangeNotifier{

  final List<Car> _list = [];


  UnmodifiableListView<Car> get cars => UnmodifiableListView(_list);

  /// The current total price of all items (assuming all items cost $42).

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Car item) {
    _list.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  void addAll(List<Car> items){
    _list.addAll(items);
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _list.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

}