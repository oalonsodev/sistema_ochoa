import 'package:flutter/material.dart';

class ProductFormProvider with ChangeNotifier {
  /// Lista de GlobalKeys.
  List<GlobalKey<FormState>> _formKeyList = [new GlobalKey<FormState>()];

  /// Iterador para indicar el Key de cada Form cuando estos se redibujan.
  int _keyIterator = 0;

  /// Indicador de que el redibujado fue por adición de un producto.
  bool becauseAdd = false;
  
  /// Debe ser establecido como ```_tabController.index```
  /// -
  /// antes de redefinir a ```_tabController```.
  /// -
  /// Indicador, para el iterador de ```ProductFormProvider```, del índice
  /// desde el que fue llamada la adición o eliminación de un tab.
  int indexPosition = 0;

  /// Indicador de que el último tab ya fue dibujado una vez.
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
  /// Este método porporciona un iterador que, mediante el uso de condiciones,
  /// asigna un Key al Form de cada ProductForm, previniendo el error del
  /// redibujado desconocido.
  /// 
  /// El redibujado sucede cuando la adición del siguiente producto se realiza
  /// teniendo en foco al último producto de la lista actual.
  /// 
  /// Es destacable que al eliminar productos no se suscita el redibujado.
  int keyIterator() {
    if (becauseAdd) {

      if ( indexPosition == _formKeyList.length - 2 && isTheLast ) {
        becauseAdd = false;
        isTheLast = false;
        return _formKeyList.length - 1;

      } else if ( _keyIterator < _formKeyList.length - 1 ) {
        increaseIterator();
        return _keyIterator - 1;

      } else {
        if ( indexPosition == _formKeyList.length - 2 ) isTheLast = true;
        resetIterator();
        return _formKeyList.length - 1;
      }

    } else {

      if ( _keyIterator < _formKeyList.length - 1 ) {
        increaseIterator();
        return _keyIterator - 1;

      } else {
        if ( _keyIterator > 0 ) resetIterator();
        return _formKeyList.length - 1;
      }

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
