import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/utils/utils.dart' as utils;

//TODO: Con la propiedad index del TabBar controlar en cuál item de mi lista de
//TODO: productos se ingresarán los datos de cada tab.

//TODO: Crear y trabajar con el modelo de productos. Hacer una lista de
//todo: productos y en base a ella controlar la cantidad de tabs y los datos de
//todo: cada unaaaaaaaa :D

//TODO: Agregar una propiedad al modelo de productos que actue como Key. Esta se
//todo: vinculará con el respectivo Tab del producto, para eliminar el del
//todo: producto que se esté visualizando. La pregunta ahora es:
//todo: ¿Como saber cuál Tab estoy visualizando?

class ProductosCot extends StatefulWidget {
	@override
	_ProductosCotState createState() => _ProductosCotState();
}

class _ProductosCotState extends State<ProductosCot>
		with TickerProviderStateMixin {
	//? Sustituir depues por la lista de productos :D
	//? ======= TabBar =======
	List<String> _tabList; //* Lista de productos
	TabController _tabController; //* Controlador del TabBar
	
	//? ======= FloatingActionButton =======
	Widget _moreOptions; //* Botón de eliminación opcional

	//? ======= Form =======
	String _unidadSelec;
	List<String> _unidad;
	String _monedaSelec;
	List<String> _moneda;

	@override
	void initState() {
		// TODO: implement initState
		super.initState();
		_tabList = ['1']; //* Valor inicial de la lista.
		_unidadSelec = 'Unidad'; //* Valor inicial del menú 'Unidad'.
		_unidad = ['Unidad','Pieza','Servicio','Ml.','Kl.','L.']; //* Lista de uni.
		_monedaSelec = 'USD';
		_moneda = ['USD','MX'];
	}

	@override
	void dispose() {
		// TODO: implement dispose
		_tabController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		//* La definición del controlador se lleva a cabo aquí para poder
		//* reescribir la propiedad 'length' con cada setState, pues esta es final
		//* lo que impide modificar el valor que se le asigna al definirlo.
		_tabController = new TabController(
			vsync: this,
			length: _tabList.length,
		);

		return Scaffold(
			appBar: AppBar(
				title: Text('Agregar productos'),
				bottom: _createTabBar(),
			),
			body: _createTabBarView(),
			floatingActionButton: _createFloatingActionButton(),
			floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
			persistentFooterButtons: _createPersistantFooterButtons(),
		);
	}

	Row _createFloatingActionButton() {
		(_tabList.length > 1)
			? _moreOptions = Row(
					children: [
						SizedBox(width: 16.0),
						FloatingActionButton(
							child: Icon(Icons.clear),
							onPressed: () {
								setState(() => _tabList.removeLast());
								//* Sentancia para remover el tab visible en pantalla
								// setState(() => _tabList.removeAt(_tabController.index));
							}
						)
					],
				)
			: _moreOptions = Row(children: [SizedBox()]);

		return Row(
			children: [
				FloatingActionButton(
					child: Icon(Icons.add),
					onPressed: () {
						//* Cuando se agrega el 2do valor a la lista, la longitud sigue
						//* siendo 1, por lo que el 2do valor repite el valor '1'. Por
						//* eso se agrega el +1, para compensar esa falta.
						setState(() => _tabList.add('${_tabList.length + 1}'));
						//* Para este momento de la ejecución el nuevo valor ya fue agregado
						//* a la lista, por lo que la longitud concuerda con lo escrito en
						//* el último valor.
					},
				),
				_moreOptions
			],
		);
	}

	List<Widget> _createPersistantFooterButtons() {
		return <Widget>[
			TextButton(child: Text('Cancelar'), onPressed: () {}),
			ElevatedButton(
					child: Text('Siguiente'),
					onPressed: () {
						print('Longitud de la lista: ${_tabList.length}');
						print('Longitud del controlador: ${_tabController.length}');
						print('${_tabController.index}');
					})
		];
	}

	TabBar _createTabBar() {
		return TabBar(
			controller: _tabController,
			isScrollable: true,
			tabs: _tabList.map((String pos) {
				return Tab(text: 'Linea $pos');
			}).toList(),
		);
	}

	TabBarView _createTabBarView() {
		return TabBarView(
			controller: _tabController,
			children: _tabList.map((String pos) {
				return ListView(
					padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
					children: [
						Form(
							child: Column(
								children: [
									_createTFFLinea(),
									utils.createSpace(24.0),
									_createTFFNombre(),
									utils.createSpace(24.0),
									_createTFFNoParte(),
									utils.createSpace(24.0),
									_createTFFMarca(),
									utils.createSpace(24.0),
									_createTFFModelo(),
									utils.createSpace(24.0),
									_createTFFCantidad(),
									utils.createSpace(24.0),
									_createDBFFUnidad(),
									utils.createSpace(24.0),
									_createComentario(),
									utils.createSpace(24.0),
									_createRowPrecioUnit(),
									utils.createSpace(24.0),
									_createSubtotal(),
								],
							),
						)
					]
				);
			}).toList(),
		);
	}

	//* Campos del formulario
	TextFormField _createTFFLinea() {
		return TextFormField(
			decoration: InputDecoration(
				labelText: 'Linea',
				border: OutlineInputBorder()
			)
		);
	}

	TextFormField _createTFFNombre() {
		return TextFormField(
			decoration: InputDecoration(
				labelText: 'Nombre del producto',
				border: OutlineInputBorder()
			)
		);
	}

	TextFormField _createTFFNoParte() {
		return TextFormField(
			decoration: InputDecoration(
				labelText: 'No. de parte',
				border: OutlineInputBorder()
			),
		);
	}

	TextFormField _createTFFMarca() {
		return TextFormField(
			decoration: InputDecoration(
				labelText: 'Marca',
			border: OutlineInputBorder()
			),
		);
	}

	TextFormField _createTFFModelo() {
		return TextFormField(
			decoration: InputDecoration(
				labelText: 'Modelo',
			border: OutlineInputBorder()
			),
		);
	}

	TextFormField _createTFFCantidad() {
		return TextFormField(
			decoration: InputDecoration(
				labelText: 'Cantidad',
				border: OutlineInputBorder()
			),
		);
	}

	Widget _createDBFFUnidad() {
		return DropdownButtonFormField<String>(
			decoration: InputDecoration(
				border: OutlineInputBorder()
			),
			value: _unidadSelec,
			items: _unidad.map(
				(String opt) => DropdownMenuItem(child: Text(opt), value: opt))
				.toList(),
			onChanged: (optSelec) => setState(() => _unidadSelec = optSelec),
		);
	}

	TextFormField _createComentario() {
		return TextFormField(
			decoration: InputDecoration(
				labelText: 'Comentario',
				border: OutlineInputBorder()
			)
		);
	}

	Row _createRowPrecioUnit() {
		return Row(
			children: [
				Expanded(
					child: DropdownButtonFormField<String>(
						decoration: InputDecoration(
							border: OutlineInputBorder()
						),
						value: _monedaSelec,      
						items: _moneda.map(
							(String opt) => DropdownMenuItem(child: Text(opt), value: opt))
							.toList(),
						onChanged: (String optSelec) => setState(() => _monedaSelec = optSelec),
					),
				),
				SizedBox(width: 16.0),
				Expanded(
					flex: 3,
					child: TextFormField(
						decoration: InputDecoration(
							labelText: 'Precio unitario',
							border: OutlineInputBorder()
						),
					)
				)
			],
		);
	}

	TextFormField _createSubtotal() {
		return TextFormField(
			decoration: InputDecoration(
				enabled: false,
				labelText: 'Subtotal',
				border: OutlineInputBorder()
			)
		);
	}

}
