import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sistema_ochoa/provider/product_form_provider.dart';
import 'package:sistema_ochoa/provider/product_list_provider.dart';

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
	//? ======= Providers =======
	ProductListProvider _productProvider; //* Proveedor de productos.
	ProductFormProvider _formProvider; //* Proveedor del formulario.

	//? ======= TabBar =======
	TabController _tabController; //* Controlador del TabBar.
	int _currentTab; //* Índice del tab seleccionado.
	bool _productWasAdded; //* Indica si el build se redibuja por adición de producto.
	
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
		_productWasAdded	= false; //* Indica si el build se redibuja por adición de producto.
		// _productList  	= [new ProductModel()]; //* Lista inical de productos.
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
		//* Definición de los provider usados
		_productProvider = Provider.of(context);
		_formProvider = Provider.of(context);

		//* La definición del controlador se lleva a cabo aquí para poder
		//* reescribir la propiedad 'length' con cada setState, pues esta es final
		//* lo que impide modificar el valor que se le asigna al definirlo.
		_tabController = new TabController(
			vsync: this,
			length: _productProvider.getProductList.length,
			//? Esta definición reinicia el _tabController.index a 0.
		);
		//* _tabController.index vuelve a 0 cada que se ejecuta el método build().
		//* Por ello, después de crear el _tabController, seteamos su valor index:
		//? 	1. Cada que se crea un nuevo tab, para que este tome el foco.
		//*		Al crear un nuevo Tab, _currentTab toma el valor de
		//*		_productList.length-1 para que, posteriormente a la ejecución de
		//*		build(), _tabController.index tome el valor de _currentTab.
		if (_productWasAdded) { //TODO: Optimzar esta condición de ser posible
			_tabController.animateTo( //? mover el foco al último tab creado.
			_productProvider.getProductList.length-1, //* _tabController.index tomará este valor.
			duration: Duration(milliseconds: 5000),
			curve: Curves.decelerate
			);
			//* Almacenar el valor index actual para actualizar el _tabController.index
			//* cuando el _tabController se redefina.
			_currentTab = _tabController.index;
			_productWasAdded = false; //* Establece a _productWasAdded como falso.

		} else {
		//?		2. Al eliminar un Tab, para que el foco se mantenga en el índice.
			_tabController.animateTo( //? mover el foco al último tab creado.
				_currentTab, //* _tabController.index tomará este valor.
				duration: Duration(milliseconds: 5000),
				curve: Curves.decelerate
			);
		}
		//? 	3. Cada que se navega entre tabs.
		//*		_tabController.index toma automáticamente el valor del Tab visualizado.

		//* Recepción del Id de la cotización que se está creando.
		final String _quotationId = ModalRoute.of(context).settings.arguments;

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
		(_productProvider.getProductList.length > 1)
			? _moreOptions = Row(
					children: [
						SizedBox(width: 16.0),
						FloatingActionButton(
							child: Icon(Icons.clear),
							onPressed: () => setState(() => _removeProduct())
						)
					],
				)
			: _moreOptions = Row(children: [SizedBox()]);

		return Row(
			children: [
				FloatingActionButton(
					child: Icon(Icons.add),
					onPressed: () => setState(() => _addProduct())
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
					print('');
				}
			),
			ElevatedButton(
				child: Text('Siguiente'),
				onPressed: () {
					if (_formProvider.formIsValid()) {
						_formProvider.saveForm();
					}
				}
			)
		];
	}

	TabBar _createTabBar() {
		return TabBar(
			controller: _tabController,
			isScrollable: true,
			tabs: _productProvider.getProductList.map((ProductModel product) {
				return Tab(text: 'Linea');
			}).toList(),
		);
	}

	TabBarView _createTabBarView() {
		//? Al redibujar, indicar los datos que debe mostrar cada ProductForm
		//? ¿Cómo? Mandandoles el ProductModel que le corresponda y seteando esos
		//? valores en los TexfFormField :D.
		//? En el momento en el que se introduzcan datos, guardarlos en el
		//? ProductModel, para que después estos datos sean usados al
		//? redibujar cada TabBarView. Así solventar el problema del índice perdido
		//? Cuando eliminamos un Tab diferente al último ingresado.
		return TabBarView(
			controller: _tabController,
			children: _productProvider.getProductList.map((ProductModel product) {
				return ProductForm(
					productModel: product, //* Nuevo cambio (error a solv.: índice perdido)
					tabController: _tabController,
					unidadSelec: _unidadSelec,
					unidad: _unidad,
					monedaSelec: _monedaSelec,
					moneda: _moneda,
					// updateProduct: _updateProduct,
				);
			}).toList(),
		);
	}

	void _addProduct() { //? Agregar producto a la lista.
		//* Indicar que la proxima llamada a build será por adición de un producto.
		_productWasAdded = true;
		//* Agregar un producto a la lista.
		_productProvider.addProduct(new ProductModel());
		//* La lista de Tabs aumenta en base a la lista de productos.
	}
	
	void _removeProduct() { //? Remover de la lista el producto visible en pantalla.
		print('_tabController.index es: ${_tabController.index}; \n'
					' _currentTab es: $_currentTab');
		_currentTab = _tabController.index; //* Indicar el actual _currentTab
		print('_currentTab se actualizó a: $_currentTab');
		_productProvider.removeProduct(_currentTab);
		print('se removió el elemento de la posición $_currentTab');
		print('La lista actual: ${_productProvider.getProductList}');
		print('Nueva longitud de la lista: ${_productProvider.getProductList.length}');

		//* Si el elemento eliminado era el último de la lista, entonces:
		if (_currentTab > _productProvider.getProductList.length-1) {
			//* Tomará el foco el actual último elemento de la lista.
			_currentTab = _productProvider.getProductList.length-1;
		}
	}
}
