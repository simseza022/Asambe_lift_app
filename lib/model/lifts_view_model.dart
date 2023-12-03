
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:lifts_app/model/lift.dart';


///Contains the relevant lifts data for our views
class LiftsViewModel extends  ChangeNotifier {
  //TODO keep track of loaded Lifts and notify views on changes
  List<Lift> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Lift> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Lift item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
  void addAll(List<Lift> list) {
    _items = list;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}