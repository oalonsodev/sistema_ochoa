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
	int _currentTab; //* Copia del índice del tab seleccionado.
	bool _productWasAdded; //* Indica si se agregó un producto.
	bool _lastProductWasRemove; //* Indica si se eliminó el producto de la última posición.
	
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
    _createTabController();
    _tabController.addListener(_listener);
		_currentTab   	  = _tabController.index; //* Copia de la posición index actual.
		_productWasAdded  = false; //* Indica si el build se redibuja por adición de producto.
		_lastProductWasRemove  = false; //* Indica si el build se redibuja por adición de producto.
		// _productList    	= [new ProductModel()]; //* Lista inical de productos.
		_unidadSelec  	  = 'Unidad'; //* Valor inicial del menú 'Unidad'.
		_unidad       	  = List.unmodifiable(['Unidad','Pieza','Servicio','Ml.','Kl.','L.']) ; //* Lista de uni.
		_monedaSelec  	  = 'USD';
		_moneda       	  = List.unmodifiable(['USD','MX']); //* Lista de monedas
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
					if (_formProvider.formIsValid(_tabController.index)) {
						_formProvider.saveForm(_tabController.index);
						print('Se guardo la información del formulario '
									'con índice ${_tabController.index}');
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
		//* Redefinir el TabController actualizando su longitud.
		_createTabController();
    //* Recorrer el foco.
    _updateFocus();
		//* Agregar un GlobalKey a la lista de GlobalKeys.
		_formProvider.addGlobalKey();
	}
	
	void _removeProduct() { //? Remover de la lista el producto visible en pantalla.
		print('_tabController.index es: ${_tabController.index}');
		_productProvider.removeProduct(_tabController.index);
		print('se removió el elemento de la posición ${_tabController.index}');
		print('La lista actual: ${_productProvider.getProductList}');
		print('Nueva longitud de la lista: ${_productProvider.getProductList.length}');

		//* Remover el GlobalKey, del formulario visible, de la lista de GlobalKeys.
		_formProvider.removeGlobalKey(_tabController.index);

		//* Si el elemento eliminado era el último de la lista, entonces:
		if (_tabController.index > _productProvider.getProductList.length-1) {
			//* Tomará el foco el actual último elemento de la lista.
      _lastProductWasRemove = true;
		}

    //* Almacenar el index actual antes de redefinir a _tabController
    //* (Para retomar la posición al eliminar un elemento diferente al último)
		_currentTab = _tabController.index;
		
    //* Redefinir el TabController actualizando su longitud.
		_createTabController();
    
    //* Recorrer el foco.
    _updateFocus();

	}

	/// La propiedad ```length``` es final, por lo que para poder editarla es 
	/// necesario redefinir a _tabController.
	/// 
	/// Este método es llamado en 2 diferentes ocasiones:
	/// * Cuando se agrega un nuevo producto a la lista.
	/// * Cuando se remueve algún producto de la lista.
	void _createTabController() {
		_tabController = new TabController(
			vsync: this,
			length: _productProvider?.getProductList?.length ?? 1,
		);
	}

	/// Debe ejecutarse después de agregar o eliminar un
  /// -
  /// producto de la lista y de redefinir a ```_tabController```.
	/// -
	/// Siempre que se redefine _tabController, su propiedad 'index' regresa a 0.
	/// Por ello, después de redefinir el _tabController, cambiamos su valor
  /// index:
	/// 
	/// **1. Cada que se crea un nuevo tab, para que este tome el foco.**
	///	Al crear un nuevo Tab, _currentTab toma el valor de _productList.length-1
	/// para que, posteriormente a la redefinición de _tabController,
	/// _tabController.index tome el valor de _currentTab.
	/// 
	/// **2. Al eliminar un Tab, para que el foco se mantenga en el índice.**
	/// En este caso pueden suceder dos cosas:
	/// 	- si el elemento eliminado era el último de la lista, ```_currentTab```
	/// tomará el valor de _productList.length-1 para que, posteriormente a la
	/// redefinición de _tabController, _tabController.index tome el valor de
	/// _currentTab.
	/// 	- si el elemento eliminado era uno distinto al último de la lista,
	/// ```_currentTab``` tomará el valor de _tabController.index para que,
	/// posteriormente a la redefinición de _tabController, _tabController.index
	/// tome el valor de _currentTab.
	/// 
	/// **3. Cada que se navega entre tabs, para actualizar a ```_currentTab```.**
  /// Cuando se navega entre ```Tab```s, ```_tabController.index``` toma
  /// automáticamente el valor índice del ```Tab``` al que se navega.
  /// Sin embargo _currentTab no; por lo que, para que sea seguro el uso
  /// externo de ```_currentTab```, hay que actualizar su valor en el mismo
  /// momento que ```_tabController.index```.
	void _updateFocus() {
		if (_productWasAdded || _lastProductWasRemove) {
			_currentTab = _productProvider.getProductList.length-1;
		} else {
			//* _currentTab mantiene su valor.
		}

		_tabController.animateTo( //? Barrer el TabBarView a la posición indicada.
      _currentTab, //* _tabController.index tomará este valor.
      duration: Duration(seconds: 5),
      curve: Curves.decelerate
		);

    //* Indicar que los siguientes casos han concluido:
		if (_productWasAdded) _productWasAdded = false;
		if (_lastProductWasRemove) _lastProductWasRemove = false;
	}

	void _listener() {
    if (_tabController.indexIsChanging) {
      setState(() {
        
      print('Tabcontroller cambió?');
      });
    }
	}
}
