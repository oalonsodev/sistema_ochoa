import 'package:flutter/material.dart';

class ProductFormProvider with ChangeNotifier {
  /// Lista de GlobalKeys.
  List<GlobalKey<FormState>> _formKeyList = [new GlobalKey<FormState>()];

  /// obtener la lista de GlobalKeys.
  List<GlobalKey<FormState>> get getFormKeyList {
    return _formKeyList;
  }

  /// Agregar un GlobalKey a la lista.
  void addGlobalKey() {
    _formKeyList.add(new GlobalKey<FormState>());

    notifyListeners();
  }

  /// Remover un GlobalKey de la lista.
  void removeGlobalKey(int index) {
    _formKeyList.remove(index);

    notifyListeners();
  }

  /// Ejecutar método save de un determinado formulario mediante su GlobalKey.
  void saveForm(int index) {
    _formKeyList[index].currentState.save();

    notifyListeners();
  }

  /// Validar los campos de un determinado formulario mediante su GlobalKey.
  bool formIsValid(int index) {
    return _formKeyList[index].currentState.validate();
  }
}
