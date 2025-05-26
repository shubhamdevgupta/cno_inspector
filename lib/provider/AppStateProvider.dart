import 'package:flutter/material.dart';

enum ProjectMode {
  below10,
  above10,
}

extension ProjectModeExtension on ProjectMode {
  int get modeValue => this == ProjectMode.below10 ? 9 : 10;
}

class AppStateProvider with ChangeNotifier {
  ProjectMode _mode = ProjectMode.below10;

  ProjectMode get mode => _mode;

  void setMode(ProjectMode newMode) {
    if (_mode != newMode) {
      _mode = newMode;
      notifyListeners();
    }
  }
}
