import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sistema_ochoa/provider/product_form_provider.dart';
import 'package:sistema_ochoa/provider/product_list_provider.dart';
import 'package:sistema_ochoa/provider/current_tab_provider.dart';

import 'package:sistema_ochoa/src/Models/product_model.dart';
import 'package:sistema_ochoa/src/pages/productos/product_form.dart';

/// TODO: ¿Implementar?
/// Modificar la forma en como se asignan los Keys a el Form de cada ProductForm.
/// Agregar una propiedad al modelo de productos que actue como Key. Esta se
/// vinculará con el respectivo Tab del producto, para eliminar el del
/// producto que se esté visualizando. La pregunta ahora es:
/// ¿Como saber cuál Tab estoy visualizando?

class ProductosCotPage extends StatefulWidget {
	@override
	_ProductosCotState createState() => _ProductosCotState();
}

class _ProductosCotState extends State<ProductosCotPage>
		with TickerProviderStateMixin {
	//? ======= Providers =======
  /// Proveedor de productos.
	ProductListProvider _productProvider;
  /// Proveedor del formulario.
	ProductFormProvider _formProvider;
  /// Proveedor del tab actual.
	CurrentTabProvider _currentTabProvider;

	//? ======= TabBar =======
	/// Controlador del TabBar.
  TabController _tabController;
	/// Indica si se agregó un producto.
  bool _productWasAdded;
	/// Indica si se eliminó el producto de la última posición.
  bool _lastProductWasRemove;
	
	//? ======= FloatingActionButton =======
	/// Botón de eliminación opcional
  Widget _moreOptions;

	@override
	void initState() {
		super.initState();
		_createTabController();
		_tabController.addListener(_listener);
    _productWasAdded  = false;
		_lastProductWasRemove  = false;
	}

	@override
	void dispose() {
		_tabController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		//* Definición de los provider usados
		_productProvider = Provider.of(context);
		_formProvider = Provider.of(context);
		_currentTabProvider = Provider.of(context);

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
					print('currentTab: ${_currentTabProvider.currentTab}');
					print('productList: ${_productProvider.getProductList}');
					print('formKeyList: ${_formProvider.getFormKeyList}');
				}
			),
			ElevatedButton(
				child: Text('Siguiente'),
				onPressed: () {
          /**Trabajar con un For in para recorrer la lista de keys
           * y ejecutar por cada una los métodos validate y save,
           * y en caso de que validate sea falso usar el index para
           * saber en cuál formulario se encontraron problemas y 
           * quizá explicarlo en pantalla con algun modal :D
           */
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

	/// ¿Cómo se crea el TabBarView? 
	/// -
	/// ```TabBarView``` recibe como hijo a una lista de ```ProductForm```s que
	/// es creada por una función```map``` en base a la lista
	/// ```_productProvider.getProductList```
	/// 
	/// **¿Cómo mantener la información de los campos de cada ProductForm?**
	/// 
	/// Cada producto de la lista ```getProductList``` es enviado como parámetro
	/// al crear su respectivo ```ProductForm```.
	/// De esta manera, cada ProductForm podrá redibujar la información de cada
	/// producto de la lista.
	TabBarView _createTabBarView() {
		return TabBarView(
			controller: _tabController,
			children: _productProvider.getProductList.map((ProductModel product) {
				return ProductForm( productModel: product );
			}).toList(),
		);
	}

	void _addProduct() { //? Agregar producto a la lista.
		//* Indicar que el siguiente cambio de foco será por adición de un producto.
		_productWasAdded = true;
    //* Indicar que el redibujado será por la adición de un producto.
    _formProvider.becauseAdd = true;
    //* Almacenar el índice actual para usarlo con el iterador de GlobalKeys.
    _formProvider.indexPosition = _tabController.index;
		//* Agregar un producto a la lista.
		_productProvider.addProduct();
		//* Agregar un GlobalKey a la lista de GlobalKeys.
		_formProvider.addGlobalKey();
		//* Redefinir el TabController actualizando su longitud.
		_createTabController();
		//* Recorrer el foco.
		_updateFocus();
	}
	
	void _removeProduct() {
    //* Indicar que el redibujado no será por la adición de un producto.
    _formProvider.becauseAdd = false;
    //* Almacenar el índice actual para usarlo con el iterador de GlobalKeys
    _formProvider.indexPosition = _tabController.index;
    //* Remover de la lista el producto visible en pantalla.
		_productProvider.removeProduct(_tabController.index);
		//* Remover el GlobalKey, del formulario visible, de la lista de GlobalKeys.
		_formProvider.removeGlobalKey(_tabController.index);
		//* Si el elemento eliminado era el último de la lista, entonces:
		if (_tabController.index > _productProvider.getProductList.length-1) {
			//* Tomará el foco el actual último elemento de la lista.
			_lastProductWasRemove = true;
		} else { //* si no
			//* Almacenar el index actual antes de redefinir a _tabController
			//* (Para retomar la posición al eliminar un elemento diferente al último)
			_currentTabProvider.currentTab = _tabController.index;
		}
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

		//* Agregar listener al controller redefinido.
		_tabController.addListener(_listener);
	}

	/// Debe ejecutarse después de agregar o eliminar un
	/// -
	/// producto de la lista y de redefinir a
	/// -
	///  ```_tabController```.
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
  /// 
	/// - si el elemento eliminado era el último de la lista, ```_currentTab```
	/// tomará el valor de _productList.length-1 para que, posteriormente a la
	/// redefinición de _tabController, _tabController.index tome el valor de
	/// _currentTab.
  /// 
  /// 
	/// - si el elemento eliminado era uno distinto al último de la lista,
	/// ```_currentTab``` tomará el valor de _tabController.index para que,
	/// posteriormente a la redefinición de _tabController, _tabController.index
	/// tome el valor de _currentTab.
	void _updateFocus() {
    /// TODO: Error
    /// Si se tienen solo 2 productos en la lista y se elimina el de la última
    /// posición, al agregar un 2do producto no se actualiza el foco.
    /// ¡Soluciónalo, Oscar del futuro! :(
		if (_productWasAdded || _lastProductWasRemove) {
			_currentTabProvider.currentTab = _productProvider.getProductList.length-1;
		}

		_tabController.animateTo( //? Barrer el TabBarView a la posición indicada.
			_currentTabProvider.currentTab, //* _tabController.index tomará este valor.
			duration: Duration(milliseconds: 1),
			curve: Curves.decelerate
		);

		//* Indicar que los siguientes casos han concluido:
		if (_productWasAdded) _productWasAdded = false;
		if (_lastProductWasRemove) _lastProductWasRemove = false;
	}

	/// Cuando se navega entre ```Tab```s, ```_tabController.index``` toma
	/// automáticamente el valor índice del ```Tab``` al que se navega.
	/// Sin embargo _currentTab no; por lo que, para que sea seguro el uso
	/// externo de ```_currentTab```, hay que actualizar su valor en el mismo
	/// momento que ```_tabController.index```.
	void _listener() {
    //* Copia de la posición index actual.
    _currentTabProvider.currentTab = _tabController.index;
    print('_currentTab es: ${_currentTabProvider.currentTab}');
	}
}