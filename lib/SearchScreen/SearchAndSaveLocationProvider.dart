import 'package:flutter/material.dart';

class SaveAndSearchLocationProvider with ChangeNotifier {
  final _searchController = TextEditingController();

  bool _validateSearch = false;

  updateValidateSearch(bool val) {
    _validateSearch = val;
    notifyListeners();
  }

  getValidateSearch() {
    return _validateSearch;
  }

  getSearchController() {
    return _searchController;
  }

  disposeSearchController() {
    return _searchController.dispose();
  }
  clearSearchController(){
    _searchController.clear();
  }
}
