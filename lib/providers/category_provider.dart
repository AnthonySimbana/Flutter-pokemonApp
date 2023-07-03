import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pokedex_mobile/dtos/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final List<CategoryModel> _categories = [];

  int get totalCategories => _categories.length;

  UnmodifiableListView<CategoryModel> get categoriesGetter =>
      UnmodifiableListView(_categories);

  void addCategory(String name) {
    _categories.add(
      CategoryModel(_categories.length + 1, name, ''),
    );
    notifyListeners();
  }

  void clearList() {
    _categories.clear();
    notifyListeners();
  }
}
