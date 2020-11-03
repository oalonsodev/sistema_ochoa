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
			//TODO: Resolver: Al colocar ambos métodos juntos, ninguno se dibuja.
			slivers: <Widget>[
				_createHeader(),
				_createBody()
			],
		);
	}

	SliverPersistentHeader _createHeader() {
		return SliverPersistentHeader(
			delegate: HeaderDelegate(),
			pinned: true
		);
	}

	SliverFillRemaining _createBody() {
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
