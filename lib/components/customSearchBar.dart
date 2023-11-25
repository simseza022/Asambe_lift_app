import 'package:flutter/material.dart';

import 'package:lifts_app/constants.dart';
import 'package:address_search_field/address_search_field.dart';


class CustomSearchBar extends StatefulWidget {
  final String hintText;

  final void Function(String selected) onPressed;
  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.onPressed,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  String kGoogleApiKey = "AIzaSyBCci3Zk-npQ9fzMvJt-LWYMMsYLqjV8Qk";
  // SearchController searchController = SearchController();
  String? _searchingWithQuery;

  // The most recent options received from the API.
  late Iterable<Widget> _lastOptions = <Widget>[];

  var suggestionsList = <ListTile>[];

  final geoMethods = GeoMethods(
      googleApiKey: "AIzaSyBCci3Zk-npQ9fzMvJt-LWYMMsYLqjV8Qk",
    language: 'en',
    countryCode: 'za',
    // country: 'South Africa'

  );
  Widget _searchBarBuilder(
      BuildContext context, SearchController searchController) {
    // searchController = searchCtrl;
    return SearchBar(
      shape: MaterialStateProperty.resolveWith((states) =>
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      backgroundColor: MaterialStateProperty.resolveWith(
          (states) => kTextFieldBackgroundColor),
      // controller: searchController,
      padding: const MaterialStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 16.0)),
      onTap: () {
        searchController.openView();
      },
      onChanged: (value) {
        searchController.openView();
      },
      onSubmitted: (val) {
        print(val);
      },

      leading: const Icon(
        Icons.search,
        color: kDarkOrangeColor,
        size: 35,
      ),
      trailing:[
        IconButton(
          padding: EdgeInsets.zero,

          onPressed: () {
            widget.onPressed("");
            searchController.clear();
          },
          icon: const Icon(
            Icons.clear,
            color: kDarkOrangeColor70,
            size: 35,
          ),
        ),
      ],
      shadowColor:
          MaterialStateProperty.resolveWith((states) => Colors.transparent),

      hintText: widget.hintText,
      hintStyle: MaterialStateProperty.resolveWith((states) => const TextStyle(
          fontWeight: FontWeight.w500, color: Color.fromRGBO(44, 51, 51, 0.5))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        // searchController: widget.searchController,
        isFullScreen: false,
        viewBackgroundColor: kLightScafoldBackgroundColor,
        viewSurfaceTintColor: Colors.transparent,
        builder: _searchBarBuilder,
        suggestionsBuilder: (context, searchController) async {
          _searchingWithQuery = searchController.text;
          final List<Address> options = await geoMethods.autocompletePlace(query: _searchingWithQuery!);
          if (_searchingWithQuery != searchController.text) {
            return _lastOptions;
          }

          _lastOptions = List<ListTile>.generate(options.length, (int index) {
            final String item = options[index].reference!;
            return ListTile(
              title: Text(item),
              onTap: () {
                widget.onPressed(item);
                searchController.closeView(item);
              },
            );
          });

          return _lastOptions;
        });
  }

// AIzaSyBCci3Zk-npQ9fzMvJt-LWYMMsYLqjV8Qk
}
