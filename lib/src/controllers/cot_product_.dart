import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sistema_ochoa/provider/current_tab_provider.dart';
import 'package:sistema_ochoa/provider/product_form_provider.dart';
import 'package:sistema_ochoa/provider/product_list_provider.dart';

mixin ProductCotController {
  //? ======= TabBar =======
	/// Controlador del TabBar.
  TabController tabController;
  /// Indica si se agregó un producto.
  bool productWasAdded;
	/// Indica si se eliminó el producto de la última posición.
  bool lastProductWasRemove;

  //? ======= Providers =======
  /// Proveedor de productos.
	ProductListProvider productProvider;
  /// Proveedor del formulario.
	ProductFormProvider formProvider;
  /// Proveedor del tab actual.
	CurrentTabProvider currentTabProvider;

  /// Definición de los provider usados
  void initProviders(BuildContext context) {
    productProvider = Provider.of(context);
		formProvider = Provider.of(context);
		currentTabProvider = Provider.of(context);
  }

	void addProduct(TickerProvider vsync) { //? Agregar producto a la lista.
		//* Indicar que el siguiente cambio de foco será por adición de un producto.
		productWasAdded = true;
    //* Indicar que el redibujado será por la adición de un producto.
    formProvider.becauseAdd = true;
    //* Almacenar el índice actual para usarlo con el iterador de GlobalKeys.
    formProvider.indexPosition = tabController.index;
		//* Agregar un producto a la lista.
		productProvider.addProduct();
		//* Agregar un GlobalKey a la lista de GlobalKeys.
		formProvider.addGlobalKey();
		//* Redefinir el TabController actualizando su longitud.
		createTabController(vsync);
		//* Recorrer el foco.
		updateFocus();
	}
	
	void removeProduct(TickerProvider vsync) {
    //* Indicar que el redibujado no será por la adición de un producto.
    formProvider.becauseAdd = false;
    //* Almacenar el índice actual para usarlo con el iterador de GlobalKeys
    formProvider.indexPosition = tabController.index;
    //* Remover de la lista el producto visible en pantalla.
		productProvider.removeProduct(tabController.index);
		//* Remover el GlobalKey, del formulario visible, de la lista de GlobalKeys.
		formProvider.removeGlobalKey(tabController.index);
		//* Si el elemento eliminado era el último de la lista, entonces:
		if (tabController.index > productProvider.getProductList.length-1) {
			//* Tomará el foco el actual último elemento de la lista.
			lastProductWasRemove = true;
		} else { //* si no
			//* Almacenar el index actual antes de redefinir a _tabController
			//* (Para retomar la posición al eliminar un elemento diferente al último)
			currentTabProvider.currentTab = tabController.index;
		}
		//* Redefinir el TabController actualizando su longitud.
		createTabController(vsync);
		//* Recorrer el foco.
		updateFocus();
	}

	/// La propiedad ```length``` es final, por lo que para poder editarla es 
	/// necesario redefinir a _tabController.
	/// 
	/// Este método es llamado en 2 diferentes ocasiones:
	/// * Cuando se agrega un nuevo producto a la lista.
	/// * Cuando se remueve algún producto de la lista.
	void createTabController(TickerProvider vsync) {
		tabController = new TabController(
			vsync: vsync,
			length: productProvider?.getProductList?.length ?? 1,
		);

		//* Agregar listener al controller redefinido.
		tabController.addListener(listener);
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
	void updateFocus() {
    /// TODO: Error
    /// Si se tienen solo 2 productos en la lista y se elimina el de la última
    /// posición, al agregar un 2do producto no se actualiza el foco.
    /// ¡Soluciónalo, Oscar del futuro! :(
		if (productWasAdded || lastProductWasRemove) {
			currentTabProvider.currentTab = productProvider.getProductList.length-1;
		}

		tabController.animateTo( //? Barrer el TabBarView a la posición indicada.
			currentTabProvider.currentTab, //* _tabController.index tomará este valor.
			duration: Duration(milliseconds: 1),
			curve: Curves.decelerate
		);

		//* Indicar que los siguientes casos han concluido:
		if (productWasAdded) productWasAdded = false;
		if (lastProductWasRemove) lastProductWasRemove = false;
	}

	/// Cuando se navega entre ```Tab```s, ```_tabController.index``` toma
	/// automáticamente el valor índice del ```Tab``` al que se navega.
	/// Sin embargo _currentTab no; por lo que, para que sea seguro el uso
	/// externo de ```_currentTab```, hay que actualizar su valor en el mismo
	/// momento que ```_tabController.index```.
	void listener() {
    //* Copia de la posición index actual.
    currentTabProvider.currentTab = tabController.index;
    print('_currentTab es: ${currentTabProvider.currentTab}');
	}

}