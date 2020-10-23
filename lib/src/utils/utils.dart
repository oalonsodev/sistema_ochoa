import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//? Utilidades de loginPage
void showMessage(BuildContext context, String mensaje) {
  
  showDialog(
    context: context,
    builder: (context){

      return AlertDialog(
        title: Text('Información incorrecta'),
        content: Text(mensaje),
        actions: <Widget>[
          
          TextButton(
            child: Text('Cerrar'),
            onPressed: () => Navigator.of(context).pop()
          )
        
        ],
      );

    }

  );
}



//? Utilidades de CotizacionesPage
bool isToday(String date) {
  var currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  if (date == currentDate)
    return true;
  else
    return false;
}

String formFieldIsEmpty(String value) {
  return (value.isEmpty) ? "Rellene este campo" : null;
}

String formFielIsNumeric(String value) {
  final number = num.tryParse(value);

  return (number == null) ? "Ingrese solo números" : null;
}

String dropDownIsValid(String value) {
  if (value == 'Condiciones de venta')
    return "Elija una opción";
  else
    return null;
}