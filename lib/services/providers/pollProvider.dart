import 'package:flutter/material.dart';

class PollsProvider extends ChangeNotifier {
  List pollsOptions = ['', ''];
  Map pollsWeights = {};
  String pollTitle = '';

  addPollOptions() {
    pollsOptions.add('');
    notifyListeners();
  }

  // addPollOptions(List value) {
  //   pollsOptions = value;
  //   notifyListeners();
  // }

  addPollWeights(Map value) {
    pollsWeights = value;
    notifyListeners();
  }

  addPollTitle(String value) {
    pollTitle = value;
    notifyListeners();
  }

  removeOption() {
    pollsOptions.removeLast();
    notifyListeners();
  }
}
