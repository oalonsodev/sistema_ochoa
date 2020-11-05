import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/pages/catalogo/header_delegate.dart';

class CatalogoPage extends StatefulWidget {
	@override
	_CatalogoPageState createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
	String _dropDownValue; //* Valor del DropdownButton

	@override
	void initState() {
		// TODO: implement initState
		_dropDownValue = 'Proveedor';
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return CustomScrollView(
			slivers: [_createHeader(), _createBody()],
		);
	}

	SliverPersistentHeader _createHeader() {
		return SliverPersistentHeader(
			delegate: HeaderDelegate(
				dropDownValue: _dropDownValue,
				updateValue: _updateText
			),
			pinned: true
		);
	}

	SliverFillRemaining _createBody() {
		// TODO: Crear FTBuilder que muestre la lista de resultados,
		// todo: y poner este widget como initialData.
		return SliverFillRemaining( //* Widget que extiende a su hijo en el area visible restante de la pantalla
			hasScrollBody: false,
			child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
			  children: [
			    Icon(Icons.search_off, size: 200.0, color: Colors.grey,),
          Text(
						'No hay búsquedas recientes',
						style: Theme.of(context).textTheme.subtitle2
					),
			  ],
			),
		);
	}

	//* Utilidades
	_updateText(String value){
		setState(() {
			_dropDownValue = value;
		});
	}
}
