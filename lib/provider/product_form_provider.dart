import 'package:flutter/material.dart';

class ProductFormProvider with ChangeNotifier {
  /// Lista de GlobalKeys.
  List<GlobalKey<FormState>> _formKeyList = [new GlobalKey<FormState>()];

  /// Iterador para indicar el Key de cada Form cuando estos se redibujan.
  int _keyIterator = 0;
  bool isTheLast = false;

  /// obtener la lista de GlobalKeys.
  List<GlobalKey<FormState>> get getFormKeyList {
    return _formKeyList;
  }

  /// Agregar un GlobalKey a la lista.
  void addGlobalKey() {
    _formKeyList.add(new GlobalKey<FormState>());

  }

  /// Remover un GlobalKey de la lista.
  void removeGlobalKey(int index) {
    _formKeyList.removeAt(index);

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
  int keyIterator(int currentTab) {
    // if (_keyIterator == _formKeyList.length) {
    //   resetIterator();
    //   // return _keyIterator;
    //   return _formKeyList.length - 1;
    // } else {
    //   increaseIterator();
    //   return _keyIterator - 1;
    // }

    if (isTheLast && currentTab == _formKeyList.length-1) {
      isTheLast = false;
      return _formKeyList.length - 1;
    } else if (_keyIterator == _formKeyList.length-1) {
      isTheLast = true;
      resetIterator();
      // return _keyIterator;
      return _formKeyList.length - 1;
    } else {
      increaseIterator();
      return _keyIterator - 1;
    }

    if (_keyIterator == _formKeyList.length) {
      isTheLast = true;
      resetIterator();
      // return _keyIterator;
      return _formKeyList.length - 1;
    } else if (isTheLast) {
      isTheLast = false;
      return _formKeyList.length - 1;
    } else {
      increaseIterator();
      return _keyIterator - 1;
    }

    // if (_keyIterator < _formKeyList.length-1) {
    //   increaseIterator();
    //   return _keyIterator - 1;
    // } else {
    //   resetIterator();
    //   // return _keyIterator;
    //   return _formKeyList.length-1;
    // }
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
