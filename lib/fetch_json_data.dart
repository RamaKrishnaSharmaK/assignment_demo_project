import 'dart:convert';

import 'package:flutter/services.dart';

class FetchJsonData {
  List _items = [];

  Future<List> loadData() async {
    final String response = await rootBundle.loadString('assets/data/assignment.json');
    final data = await json.decode(response);
    _items = data["products"];
    return _items;
  }
}
