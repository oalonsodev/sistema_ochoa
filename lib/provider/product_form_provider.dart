import 'package:flutter/material.dart';

class ProductFormProvider with ChangeNotifier {
  /// Lista de GlobalKeys.
  List<GlobalKey<FormState>> _formKeyList = [new GlobalKey<FormState>()];

  /// Iterador para indicar el Key de cada Form cuando estos se redibujan.
  int _keyIterator = 0;

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
    _formKeyList.removeAt(index);

    notifyListeners();
  }

  /// Ejecutar método save de un determinado formulario mediante su GlobalKey.
  void saveForm(int index) {
    _formKeyList[index].currentState.save();
  }

  /// Validar los campos de un determinado formulario mediante su GlobalKey.
  bool formIsValid(int index) {
    return _formKeyList[index].currentState.validate();
  }

  /// Obtener el iterador de Keys.
  /// -
  /// Se retorna ```_keyIterator-1``` debido a que ```increaseIterator()```
  /// ya fué llamado.
  int keyIterator() {
    if (_keyIterator == _formKeyList.length) {
      resetIterator();
      // return _keyIterator;
      return _formKeyList.length-1;
    } else {
      increaseIterator();
      return _keyIterator - 1;
    }
    
  }

  /// Aumentar en uno el valor del iterador.
  void increaseIterator() {
    _keyIterator++;

  }

  /// Restablecer iterador.
  void resetIterator() {
    _keyIterator = 0;

  }
}
