import 'package:flutter/material.dart';

class CurrentTabProvider with ChangeNotifier {
  /// Indicador del índice del tab visible en pantalla actualmente.
  int currentTab = 0;
}
