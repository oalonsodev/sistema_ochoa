import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sistema_ochoa/provider/product_form_provider.dart';
import 'package:sistema_ochoa/provider/product_list_provider.dart';
import 'package:sistema_ochoa/provider/quotation_provider.dart';

class SavePage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		String action = ModalRoute.of(context).settings.arguments;

		final TextStyle titleStyle =
			Theme.of(context).textTheme.headline4.apply( color: Colors.indigo );
		final TextStyle captionStyle =
			Theme.of(context).textTheme.headline5.apply( color: Colors.indigo );

		String subject;
		String title;
		String caption;
		String buttonTitle;
		Function buttonFunction; 

		switch ( action ) {
			case 'Save':
				subject = 'Datos guardados';
				title 	= 'Cotización registrada';
				caption = 'Los productos fueron almacenados.\n'
									'Asegúrese de solicitar la cotización pronto.';
				buttonTitle = 'Cotizar ahora';
				buttonFunction = () {
					// TODO: Pendiente
					/// Colocar aquí el código encargado de redirigir a la pantalla de
					/// elección de proveedores.
					print('Cotizar ahora');
				};
				break;
			case 'Request':
				subject = 'Datos guardados';
				title 	= 'Cotización en proceso';
				caption = 'Verifique su buzón de salida para\n'
									'editar los correos individuales';
				buttonTitle = 'Abrir correo';
				buttonFunction = () {
					// TODO: Pendiente
					/// Colocar aquí el código encargado de abrir la aplicación
					/// predeterminada de correos.
					print('Abrir correo');
				};
				break;
			default:
				subject = 'subjec';
				title 	= 'title';
				caption = 'caption';
		}

		return Scaffold(
			appBar: AppBar(
				title: Text( subject ?? 'subject' ),
				centerTitle: true
			),
			
			body: _createBody( title, caption, titleStyle, captionStyle ),
			persistentFooterButtons: _createPersistentFooterButtons(
				context, buttonTitle, buttonFunction
			),
		);
	}

	Widget _createBody( String title, String caption,
											TextStyle titleStyle, TextStyle captionStyle ) {
		return Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Icon(Icons.check_circle, size: 96.0),
					SizedBox(height: 8.0),
					Text(title ?? 'title', style: titleStyle),
					SizedBox(height: 8.0),
					Text(
						caption ?? 'caption',
						style: captionStyle,
						textAlign: TextAlign.center
					)
				],
			),
		);
	}

	List<Widget> _createPersistentFooterButtons(BuildContext context, String buttonTitle, Function f) {
		//? => Providers
		/// Proveedor de la cotización actual.
		QuotationProvider quotationProvider = Provider.of(context);
		/// Proveedor de productos
		ProductListProvider productProvider = Provider.of(context);
		/// Provedor de GlobalKeys
		ProductFormProvider formProvider = Provider.of(context);

		return [
			TextButton(
				child: Text('Finalizar'),
				onPressed: () {
					//? Vaciar la lista de productos local.
					productProvider.clearList();
					
					//? Vaciar la lista de llaves locales.
					formProvider.clearList();

					//? Restaurar la cotización local.
					quotationProvider.resetQuotation();

					Navigator.pushReplacementNamed(context, 'home');
				},
			),
			ElevatedButton(
				child: Text(buttonTitle ?? 'buttonTitle'),
				onPressed: () => f,
			)
		];
	}
}