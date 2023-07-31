import 'package:flutter/material.dart';

class PollsProvider extends ChangeNotifier {
  List pollsOptions = ['', ''];
  Map pollsWeights = {};
  String pollTitle = '';

  addPollOptions(List value) {
    pollsOptions = value;
    notifyListeners();
  }

  addPollWeights(Map value) {
    pollsWeights = value;
    notifyListeners();
  }

  addPollTitle(String value) {
    pollTitle = value;
    notifyListeners();
  }

  // removeOption(int index) {
  //   pollsOptions.removeAt(index);
  //   notifyListeners();
  // }

}
