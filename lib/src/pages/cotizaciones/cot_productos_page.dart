import 'package:flutter/material.dart';
import 'package:sistema_ochoa/src/Models/product_model.dart';
import 'package:sistema_ochoa/src/pages/productos/product_form.dart';

//TODO: Con la propiedad index del TabBar controlar en cuál item de mi lista de
//todo: productos se ingresarán los datos de cada tab.

//TODO: Crear y trabajar con el modelo de productos. Hacer una lista de
//todo: productos y en base a ella controlar la cantidad de tabs y los datos de
//todo: cada unaaaaaaaa :D

//TODO: Agregar una propiedad al modelo de productos que actue como Key. Esta se
//todo: vinculará con el respectivo Tab del producto, para eliminar el del
//todo: producto que se esté visualizando. La pregunta ahora es:
//todo: ¿Como saber cuál Tab estoy visualizando?

class ProductosCotPage extends StatefulWidget {
	@override
	_ProductosCotState createState() => _ProductosCotState();
}

class _ProductosCotState extends State<ProductosCotPage>
		with TickerProviderStateMixin {
	List<ProductModel> _productList; //* Lista de productos.

	//? ======= TabBar =======
	TabController _tabController; //* Controlador del TabBar.
	int _currentTab; //* Índice del tab seleccionado.
	bool _isProductAdded; //* Indica si el build se redibuja por adición de producto.
	
	//? ======= FloatingActionButton =======
	Widget _moreOptions; //* Botón de eliminación opcional

	//? ======= Form =======
	String        _unidadSelec;
	List<String>  _unidad;
	String        _monedaSelec;
	List<String>  _moneda;

	@override
	void initState() {
		// TODO: implement initState
		super.initState();
		_currentTab   	= 0; //* Indice indicador del tab inicial
		_isProductAdded	= false; //* Indica si el build se redibuja por adición de producto.
		_productList  	= [new ProductModel()]; //* Lista inical de productos.
		_unidadSelec  	= 'Unidad'; //* Valor inicial del menú 'Unidad'.
		_unidad       	= List.unmodifiable(['Unidad','Pieza','Servicio','Ml.','Kl.','L.']) ; //* Lista de uni.
		_monedaSelec  	= 'USD';
		_moneda       	= List.unmodifiable(['USD','MX']); //* Lista de monedas
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
			length: _productList.length,
		);
		//* _tabController.index vuelve a 0 cada que se ejecuta el método build().
		//* Por ello, después de crear el _tabController, seteamos su valor index:
		//? 	1. Cada que se crea un nuevo tab.
		//*		Al crear un nuevo Tab, _currentTab toma el valor de
		//*		_productList.length-1 para que, posteriormente a la ejecución de
		//*		build(), _tabController.index tome el valor de _currentTab.
		if (_isProductAdded) {
			_tabController.index = _currentTab; //! Problema aqui al borrar producto
		}
		_isProductAdded = false; //* Establece a _isProductAdded como falso.
		//? 	2. Cada que se navega entre tabs.
		//*		_tabController.index toma automáticamente el valor del Tab visualizado.


		//? Este es el código que mueve el foco al último tab creado.
		_tabController.animateTo(
			_productList.length-1, //* _tabController.index tomará este valor.
			duration: Duration(milliseconds: 5000),
			curve: Curves.decelerate
		);
		_currentTab = _tabController.index; //* Almacenamos el valor index actual. 


		//* Recepción del Id de la cotización que se está creando.
		final String _quotationId = ModalRoute.of(context).settings.arguments;

		// //TODO: Eliminar esta condición al terminar esta ruta
		// //* Condición momentanea para utilizar la página sin recibir datos de CotizacionesPage
		// if (_quotationId != null) {
		// 	//? mostrar en consola los datos de la cotización _quotetion.
		// 	print(_quotationId);
		// }

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
		(_productList.length > 1)
			? _moreOptions = Row(
					children: [
						SizedBox(width: 16.0),
						FloatingActionButton(
							child: Icon(Icons.clear),
							onPressed: () {
								setState(() {
									_removeProduct();
								});
								//* Sentancia para remover el tab visible en pantalla
								// setState(() => _productList.removeAt(_tabController.index));
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
						setState(() {
							_addProduct();
						});

						// //TODO: Usar este método para colocar el foco en el último tab
						// //todo: creado.
						// //* Lineas encargadas de realizar el cambio entre pestañas
						// _tabController.animateTo(
						// 	_productList.length-1, //* _tabController.index tomará este valor
						// 	duration: Duration(milliseconds: 5000),
						// 	curve: Curves.decelerate
						// );
						// //* Para este momento _tabController.index ya cambió de valor.
						// _currentTab = _tabController.index;
					},
				),
				_moreOptions
			],
		);
	}

	List<Widget> _createPersistantFooterButtons() {
		return <Widget>[
			TextButton(
				child: Text('Cancelar'),
				onPressed: () {
				 print('Tab actual: ${_tabController.index}');
				 print('Tab actual: $_currentTab');
				 print('La lista actual: $_productList');
				 print('Longitud de la lista: ${_productList.length}');
			}),
			ElevatedButton(
				child: Text('Siguiente'),
				onPressed: () {}
			)
		];
	}

	TabBar _createTabBar() {
		return TabBar(
			controller: _tabController,
			isScrollable: true,
			tabs: _productList.map((ProductModel product) {
				return Tab(text: 'Linea');
			}).toList(),
		);
	}

	TabBarView _createTabBarView() {
		return TabBarView(
			controller: _tabController,
			children: _productList.map((ProductModel product) {
				return ProductForm(
					tabController: _tabController,
					unidadSelec: _unidadSelec,
					unidad: _unidad,
					monedaSelec: _monedaSelec,
					moneda: _moneda
				);
			}).toList(),
		);
	}

	void _addProduct() { //? Agregar producto a la lista.
		_isProductAdded = true;

		_productList.add(new ProductModel());
		//? La lista de Tabs aumenta en base a la lista de productos.
		print('previousIndex: ${_tabController.previousIndex}');
		print('Index: ${_tabController.index}');
		print('Current Tab: $_currentTab');
		print('se agregó un elemento a la lista');
		print('La lista actual: $_productList');
		print('Nueva longitud de la lista: ${_productList.length}');

		
	}
	
	void _removeProduct() {
		//? Remover de la lista el producto visible en pantalla
		// int _nextIndex;
		// if (_tabController.index == 0
		// 		|| _tabController.index == _productList.length-1) {
		// 	_nextIndex = _tabController.index;
		// } else {
		// }

		_productList.removeAt(_currentTab);
		print('se removió el elemento de la posición $_currentTab');
		print('La lista actual: $_productList');
		print('Nueva longitud de la lista: ${_productList.length}');

		// //* Lineas encargadas de realizar el cambio entre pestañas
		// _tabController.animateTo(
		// 	_productList.length-1, //* _tabController.index tomará este valor
		// 	duration: Duration(milliseconds: 5000),
		// 	curve: Curves.decelerate
		// );
		// _currentTab = _tabController.index;

	}

}
