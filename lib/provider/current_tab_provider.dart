import 'package:flutter/material.dart';

class CurrentTabProvider with ChangeNotifier {
  /// Indicador del índice del tab visible en pantalla actualmente.
  int currentTab = 0;

  /// Debe ser establecido como ```_tabController.index```
  /// -
  /// antes de redefinir a ```_tabController```.
  /// -
  /// Indicador, para el iterador de ```ProductFormProvider```, del índice
  /// desde el que fue llamada la adición o eliminación de un tab.
  int forIterator = 0;

}
