import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/pages/clientes/header_delegate.dart';

class ClientesPage extends StatefulWidget {
	@override
	_ClientesPageState createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
	
	@override
	Widget build(BuildContext context) {
		return CustomScrollView(
			slivers: <Widget>[
				_createHeader(),
				_createBody(context)
			],
		);
	}

	SliverPersistentHeader _createHeader() {
		return SliverPersistentHeader(
			delegate: HeaderDelegate(),
			pinned: true
		);
	}

	SliverFillRemaining _createBody(BuildContext context) {
		/// TODO: ¿Implementar?
    /// Crear FTBuilder que muestre la lista de resultados y poner este widget
    /// como initialData.
    return SliverFillRemaining(
			hasScrollBody: false,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Icon(Icons.people, size: 200.0, color: Colors.grey),
					Text(
						'No hay clientes para mostrar',
						style: Theme.of(context).textTheme.subtitle2,
					)
				],
			)
		);
	}

	//* utilidades

}
