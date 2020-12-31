import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/models/product_model.dart';
import 'package:sistema_ochoa/src/views/productos/product_form.dart';
import 'package:sistema_ochoa/src/controllers/quotations/cot_product_controller.dart';

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
		with TickerProviderStateMixin, ProductCotController {
	//? ======= FloatingActionButton =======
	/// Botón de eliminación opcional
  Widget _moreOptions;

	@override
	void initState() {
		super.initState();
    productService = new ProductService();
		createTabController(this);
		tabController.addListener(listener);
    productWasAdded  = false;
		lastProductWasRemove  = false;
	}

	@override
	void dispose() {
		tabController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {

    initProviders(context);

		//* Recepción del Id de la cotización que se está creando.
		final String _quotationId = ModalRoute.of(context).settings.arguments;

		return Scaffold(
			appBar: AppBar(
				title: Text('Agregar productos'),
				bottom: _createTabBar(),
			),
			body: _createTabBarView(),
			floatingActionButton: _createFloatingActionButton(context),
			floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
			persistentFooterButtons: _createPersistantFooterButtons(),
		);
	}

	Row _createFloatingActionButton(BuildContext context) {
		(productProvider.getProductList.length > 1)
			? _moreOptions = Row(
					children: [
						SizedBox(width: 16.0),
						FloatingActionButton(
              heroTag: 'FAB2',
							child: Icon(Icons.clear),
							onPressed: () => _dialogRemove(context)
						)
					],
				)
			: _moreOptions = Row(children: [SizedBox()]);

		return Row(
			children: [
				FloatingActionButton(
          heroTag: 'FAB1',
					child: Icon(Icons.add),
					onPressed: () => setState(() => addProduct(this))
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
					print('currentTab: ${currentTabProvider.currentTab}');
					print('productList: ${productProvider.getProductList}');
					print('formKeyList: ${formProvider.getFormKeyList}');
				}
			),
      Builder(
        builder: (BuildContext context) => ElevatedButton(
          child: Text('Siguiente'),
          onPressed: () => nextStep(context)
        )
      )
			
		];
	}

	TabBar _createTabBar() {
		return TabBar(
			controller: tabController,
			isScrollable: true,
			tabs: productProvider.getProductList.map((ProductModel product) {
				return Tab(text: 'Linea');
			}).toList(),
		);
	}

	/// ¿Cómo se crea el TabBarView? 
	/// -
	/// ```TabBarView``` recibe como hijo a una lista de ```ProductForm```s que
	/// es creada por una función```map``` en base a la lista
	/// ```productProvider.getProductList```
	/// 
	/// **¿Cómo mantener la información de los campos de cada ProductForm?**
	/// 
	/// Cada producto de la lista ```getProductList``` es enviado como parámetro
	/// al crear su respectivo ```ProductForm```.
	/// De esta manera, cada ProductForm podrá redibujar la información de cada
	/// producto de la lista.
	TabBarView _createTabBarView() {
		return TabBarView(
			controller: tabController,
			children: productProvider.getProductList.map((ProductModel product) {
				return ProductForm( productModel: product );
			}).toList(),
		);
	}

  void _dialogRemove(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¿Eliminar producto?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop()
            ),
            ElevatedButton(
              child: Text('Eliminar'),
              onPressed: () => setState(() {
                Navigator.of(context).pop();
                removeProduct(this);
              })
            )
          ],
        );
      },
    );
  }
}