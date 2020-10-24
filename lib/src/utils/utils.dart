import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//? Utilidades de loginPage
void showError(BuildContext context, String mensaje) {
	showDialog(
		context: context,
		builder: (context) {

			switch (mensaje) {
				//* Errores de inicio de sesión
				case 'EMAIL_NOT_FOUND':
					mensaje = 'Correo incorrecto o inexistente.';

					break;
				case 'INVALID_PASSWORD':
					mensaje = 'Contraseña incorrecta.';
					break;

				case 'USER_DISABLED':
					mensaje = 'Este usuario ha sido desactivado por el administrador del'
							' sitio.';
					break;

				//* Errores de registro
				case 'EMAIL_EXISTS':
					mensaje = 'Esta dirección de correo electrónico ya está siendo'
							' utlizada por otra cuenta.';
					break;

				case 'OPERATION_NOT_ALLOWED':
					mensaje = 'El inicio de sesión con contraseña está inhabilitado para'
							' este proyecto.';
					break;

				case 'TOO_MANY_ATTEMPTS_TRY_LATER':
					mensaje = 'Hemos bloqueado todas las solicitudes de este dispositivo'
							' debido a una actividad inusual. Inténtelo de nuevo más tarde.';
					break;

				default: mensaje = '';
			}

			return AlertDialog(
				title: Text('Información incorrecta'),
				content: Text(mensaje),
				actions: <Widget>[
					TextButton(
							child: Text('Cerrar'),
							onPressed: () => Navigator.of(context).pop())
				],
			);
		});
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
