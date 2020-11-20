import 'package:flutter/material.dart';

class ProductFormProvider with ChangeNotifier {
  //* Global Key del formulario.
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  //* obtener el GlobalKey.
  GlobalKey<FormState> get getFormKey {
    return _formKey;
  }

  //* ejecutar el método save.
  void saveForm() {
    _formKey.currentState.save();

    notifyListeners();
  }

  //* Validar los campos del formulario.
  bool formIsValid() {
    return _formKey.currentState.validate();
  }
}
