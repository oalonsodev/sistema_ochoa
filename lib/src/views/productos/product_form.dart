import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sistema_ochoa/provider/product_form_provider.dart';
import 'package:sistema_ochoa/provider/product_list_provider.dart';
import 'package:sistema_ochoa/provider/current_tab_provider.dart';

import 'package:sistema_ochoa/src/utils/utils.dart' as utils;
import 'package:sistema_ochoa/src/Models/product_model.dart';

class ProductForm extends StatefulWidget {
	final ProductModel productModel;

	ProductForm({this.productModel});

	@override
	_ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm>
		with AutomaticKeepAliveClientMixin {
	//? getter heredado para mantener el estado del widget
	@override
	bool get wantKeepAlive => true;

	//? ======= Providers =======
	ProductListProvider _productProvider; //* Proveedor de productos.
	ProductFormProvider _formProvider; //* Proveedor del formulario.
	CurrentTabProvider _currentTabProvider; //* Proveedor del tab actual.

	//? ======= Form =======
  GlobalKey<FormState> formKey;
	String        _unidadSelec;
	List<String>  _unidad;
	String        _monedaSelec;
	List<String>  _moneda;

	//? ======= Controladores =======
	TextEditingController _controllerLinea;
	TextEditingController _controllerNombre;
	TextEditingController _controllerNoParte;
	TextEditingController _controllerMarca;
	TextEditingController _controllerModelo;
	TextEditingController _controllerCantidad;
	TextEditingController _controllerUnidad;
	TextEditingController _controllerComentario;

	@override
	void initState() {
		// TODO: implement initState
		super.initState();
    print('initState HashCode: ${this.hashCode}');
		_unidadSelec  = 'Unidad'; //* Valor inicial del menú 'Unidad'.
		_unidad       = List.unmodifiable(['Unidad','Pieza','Servicio','Ml.','Kl.','L.']) ; //* Lista de uni.
		_monedaSelec  = 'USD';
		_moneda       = List.unmodifiable(['USD','MX']); //* Lista de monedas
		_controllerLinea			= new TextEditingController();
		_controllerLinea			= new TextEditingController();
		_controllerNombre			= new TextEditingController();
		_controllerNoParte		= new TextEditingController();
		_controllerMarca			= new TextEditingController();
		_controllerModelo			= new TextEditingController();
		_controllerCantidad		= new TextEditingController();
		_controllerUnidad			= new TextEditingController();
		_controllerComentario	= new TextEditingController();
	}

	@override
	void dispose() {
    print('se eliminó: ${this.hashCode}');
		// TODO: implement dispose
    // _formProvider.getFormKeyList[_currentTabProvider.currentTab].currentState.dispose();
    _controllerLinea.dispose();
		_controllerNombre.dispose();
		_controllerNoParte.dispose();
		_controllerMarca.dispose();
		_controllerModelo.dispose();
		_controllerCantidad.dispose();
		_controllerUnidad.dispose();
		_controllerComentario.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		super.build(context);

		//? ======= Providers =======
		_productProvider = Provider.of(context);
		_formProvider = Provider.of(context);
		_currentTabProvider = Provider.of(context);
		
		//* Las siguientes lineas permiten que en los TextFormFields se redibujen
		//* los datos actuales por cada producto de la lista de productos.
		//* (para que se vayan los elementos que eliminemos 😉)
		_controllerLinea.text				= widget.productModel.linea?.toString() ?? '';
		_controllerNombre.text 			= widget.productModel.nombre ?? '';
		_controllerNoParte.text 		= widget.productModel.noParte?.toString() ?? '';
		_controllerMarca.text 			= widget.productModel.marca ?? '';
		_controllerModelo.text 			= widget.productModel.modelo ?? '';
		_controllerCantidad.text 		= widget.productModel.cantidad?.toString() ?? '';
		_controllerUnidad.text 			= widget.productModel.unidad ?? '';
		_controllerComentario.text 	= widget.productModel.comentario ?? '';

		return ListView(
			padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
			children: [
				Form(
					key: _formProvider.getFormKeyList[_formProvider.keyIterator()],
					autovalidateMode: AutovalidateMode.onUserInteraction,
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
							_createDBFFUnidad(_unidadSelec, _unidad),
							utils.createSpace(24.0),
							_createComentario(),
							utils.createSpace(24.0),
							_createRowPrecioUnit(_monedaSelec, _moneda),
							utils.createSpace(24.0),
							_createSubtotal(),
						],
					),
				)
			]
		);
	}

	//* Campos del formulario
	TextFormField _createTFFLinea() {
		return TextFormField(
			controller: _controllerLinea,
			decoration: InputDecoration(
				labelText: 'Linea',
				border: OutlineInputBorder()
			),
			onFieldSubmitted: (value) {
				_productProvider.updateProduct(
					_currentTabProvider.currentTab,
					linea: num.parse(value)
				);
				print('se escribió $value');
			},
			validator: (value) {
				return utils.formFieldIsNumeric(value);
			},
			onSaved: (value) {
				print('$value fue guardado por onSave');
			},
		);
	}

	TextFormField _createTFFNombre() {
		return TextFormField(
			decoration: InputDecoration(
					labelText: 'Nombre del producto', border: OutlineInputBorder()),
		);
	}

	TextFormField _createTFFNoParte() {
		return TextFormField(
			decoration: InputDecoration(
					labelText: 'No. de parte', border: OutlineInputBorder()),
		);
	}

	TextFormField _createTFFMarca() {
		return TextFormField(
			decoration:
					InputDecoration(labelText: 'Marca', border: OutlineInputBorder()),
		);
	}

	TextFormField _createTFFModelo() {
		return TextFormField(
			decoration:
					InputDecoration(labelText: 'Modelo', border: OutlineInputBorder()),
		);
	}

	TextFormField _createTFFCantidad() {
		return TextFormField(
			decoration:
					InputDecoration(labelText: 'Cantidad', border: OutlineInputBorder()),
		);
	}

	Widget _createDBFFUnidad(String unidadSelec, List<String> unidad) {
		return DropdownButtonFormField<String>(
			decoration: InputDecoration(border: OutlineInputBorder()),
			value: unidadSelec,
			items: unidad
					.map((String opt) => DropdownMenuItem(child: Text(opt), value: opt))
					.toList(),
			onChanged: (optSelec) => unidadSelec = optSelec,
		);
	}

	TextFormField _createComentario() {
		return TextFormField(
				decoration: InputDecoration(
						labelText: 'Comentario', border: OutlineInputBorder()));
	}

	Row _createRowPrecioUnit(String monedaSelec, List<String> moneda) {
		return Row(
			children: [
				Expanded(
					child: DropdownButtonFormField<String>(
						decoration: InputDecoration(border: OutlineInputBorder()),
						value: monedaSelec,
						items: moneda
								.map((String opt) =>
										DropdownMenuItem(child: Text(opt), value: opt))
								.toList(),
						onChanged: (String optSelec) => monedaSelec = optSelec,
					),
				),
				SizedBox(width: 16.0),
				Expanded(
						flex: 3,
						child: TextFormField(
							decoration: InputDecoration(
									labelText: 'Precio unitario', border: OutlineInputBorder()),
						))
			],
		);
	}

	TextFormField _createSubtotal() {
		return TextFormField(
				decoration: InputDecoration(
						enabled: false,
						labelText: 'Subtotal',
						border: OutlineInputBorder()));
	}
}
