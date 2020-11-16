import 'package:flutter/material.dart';
import 'package:sistema_ochoa/src/utils/utils.dart' as utils;

class ProductForm extends StatefulWidget {
	final TabController tabController;
	final String unidadSelec;
	final List<String> unidad;
	final String monedaSelec;
	final List<String> moneda;

	ProductForm({
		this.tabController,
		this.unidadSelec,
		this.unidad,
		this.monedaSelec,
		this.moneda
	});

	@override
	_ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> with AutomaticKeepAliveClientMixin {
	@override
  bool get wantKeepAlive => true;

	final _formKey = new GlobalKey<FormState>();
	
	@override
	Widget build(BuildContext context) {
		super.build(context);
		return ListView(
			padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
			children: [
				Form(
					key: _formKey,
					autovalidateMode: AutovalidateMode.onUserInteraction,
					child: Column(
						children: [
							_createTFFLinea(),
							utils.createSpace(24.0),
							_createTFFNombre(widget.tabController),
							utils.createSpace(24.0),
							_createTFFNoParte(),
							utils.createSpace(24.0),
							_createTFFMarca(),
							utils.createSpace(24.0),
							_createTFFModelo(),
							utils.createSpace(24.0),
							_createTFFCantidad(),
							utils.createSpace(24.0),
							_createDBFFUnidad(widget.unidadSelec, widget.unidad),
							utils.createSpace(24.0),
							_createComentario(),
							utils.createSpace(24.0),
							_createRowPrecioUnit(widget.monedaSelec, widget.moneda),
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
			decoration: InputDecoration(
				labelText: 'Linea',
				border: OutlineInputBorder()
			),
		);
	}

	TextFormField _createTFFNombre(TabController tabController) {
		return TextFormField(
			decoration: InputDecoration(
				labelText: 'Nombre del producto',
				border: OutlineInputBorder()
			),
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

	Widget _createDBFFUnidad(String unidadSelec, List<String> unidad) {
		return DropdownButtonFormField<String>(
			decoration: InputDecoration(border: OutlineInputBorder()),
			value: unidadSelec,
			items: unidad.map((String opt) =>
				DropdownMenuItem(child: Text(opt), value: opt))
				.toList(),
			onChanged: (optSelec) => setState(() => unidadSelec = optSelec),
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

	Row _createRowPrecioUnit(String monedaSelec, List<String> moneda) {
		return Row(
			children: [
				Expanded(
					child: DropdownButtonFormField<String>(
						decoration: InputDecoration(border: OutlineInputBorder()),
						value: monedaSelec,
						items: moneda.map((String opt) =>
							DropdownMenuItem(child: Text(opt), value: opt))
							.toList(),
						onChanged: (String optSelec) =>
							setState(() => monedaSelec = optSelec),
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
