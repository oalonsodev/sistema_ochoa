import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sistema_ochoa/src/views/cotizaciones/header_delegate.dart';
import 'package:sistema_ochoa/src/utils/utils.dart' as utils;

import 'package:sistema_ochoa/src/services/quotation_service.dart';
import 'package:sistema_ochoa/src/models/quotation_model.dart';

class CotizacionesPage extends StatefulWidget {
	@override
	CotizacionesPageState createState() => CotizacionesPageState();
}

class CotizacionesPageState extends State<CotizacionesPage> {
	GlobalKey<FormState> _formKey; //* Key del Widget Form
	QuotationModel _quotation; //* Modelo de producto
	QuotationService _quotationService; //* Proveedor de métodos para los procesos REST de productos
	
	//* ======= PageOne =======
	//? Valores del formulario
	String _condicionVentaSelec;
	List<String> _condicionesV;
  bool _sendingQuotation;
	//? Controladores
	TextEditingController _controllerDatePicker;

	//* ======= PageTwo =======
	String _dropDownValuePage2;

	@override
	void initState() {
		super.initState();
    _formKey              = new GlobalKey<FormState>();
		_quotation						= new QuotationModel();
		_quotationService    	= new QuotationService();
    _sendingQuotation     = false;
		_condicionVentaSelec	= 'Condiciones de venta';
		_condicionesV = [
			'Condiciones de venta',
			'De contado',
			'A crédito',
			'50% de contado, 50% a crédito'
		];
		_controllerDatePicker	= new TextEditingController();
		_dropDownValuePage2		= 'No. de folio';
	}

	@override
	void dispose() {
		_controllerDatePicker.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		//* Asignar valor inicial al TextFormField del DatePicker sin afectar a las
		//* asignaciones hechas desde el DatePicker.
		//! SI coloco el valor directamente en product.fecha pues es un valor que
		//! viene predefinido con la fecha actual en todas las cotizaciones.
		if ( utils.isToday(_quotation.fecha) )
			_controllerDatePicker.text = _quotation.fecha;

		return TabBarView(children: [
			_pageOne(context),
			_pageTwo(),
		]);
	}

	Widget _pageOne(BuildContext context) {
		return SingleChildScrollView(
			padding: EdgeInsets.all(16.0),
			child: Form(
				key: _formKey,
				child: Column(
					children: [
						utils.createLabelDivider(context, 'Datos de cotización'),
						_createTFFDatePicker(context),
						utils.createSpace(16.0),
						_createTFFFolio(),
						utils.createSpace(16.0),
						_createTFFNoReq(),
						utils.createSpace(24.0),
						utils.createLabelDivider(context, 'Datos del cliente'),
						_createTFFCliente(),
						utils.createSpace(16.0),
						_createTFFDireccion(),
						utils.createSpace(16.0),
						_createTFFComprador(),
						utils.createSpace(16.0),
						_createTFFDepartamento(),
						utils.createSpace(24.0),
						utils.createLabelDivider(context, 'Otros datos'),
						_createDBFFCondicionesV(),
						utils.createSpace(16.0),
						_createTFFTiempoE(),
						utils.createSpace(24.0),
						_createButton(context)
					],
				),
			),
		);
	}

	Widget _pageTwo() {
		return CustomScrollView(
			slivers: <Widget>[_createHeader(), _createBody()],
		);
	}

	//? Página 1: "Nueva cotización"
	TextFormField _createTFFDatePicker(BuildContext context) {
		return TextFormField(
			controller: _controllerDatePicker,
			decoration: InputDecoration(
					labelText: 'Fecha de solicitud', border: OutlineInputBorder()),
			onTap: () => _createDatePicker(context),
			validator: (value) => utils.formFieldIsNotEmpty(value),
			onSaved: (value) => _quotation.fecha = value,
		);
	}

	TextFormField _createTFFFolio() {
		return TextFormField(
			decoration: InputDecoration(
					labelText: 'Folio de la cotización', border: OutlineInputBorder()),
			validator: (value) => utils.formFieldIsNotEmpty(value),
			onSaved: (value) => _quotation.folio = value,
		);
	}

	TextFormField _createTFFNoReq() {
		return TextFormField(
			decoration: InputDecoration(
					labelText: 'No. de requisición', border: OutlineInputBorder()),
			validator: (value) => utils.formFieldIsNumeric(value),
			onSaved: (value) => _quotation.noReq = num.parse(value),
		);
	}

	TextFormField _createTFFCliente() {
		return TextFormField(
			decoration:
					InputDecoration(labelText: 'Cliente', border: OutlineInputBorder()),
			validator: (value) => utils.formFieldIsNotEmpty(value),
			onSaved: (value) => _quotation.cliente = value,
		);
	}

	TextFormField _createTFFDireccion() {
		return TextFormField(
			decoration:
					InputDecoration(labelText: 'Dirección', border: OutlineInputBorder()),
			validator: (value) => utils.formFieldIsNotEmpty(value),
			onSaved: (value) => _quotation.direccion = value,
		);
	}

	TextFormField _createTFFComprador() {
		return TextFormField(
			decoration:
					InputDecoration(labelText: 'Comprador', border: OutlineInputBorder()),
			validator: (value) => utils.formFieldIsNotEmpty(value),
			onSaved: (value) => _quotation.comprador = value,
		);
	}

	TextFormField _createTFFDepartamento() {
		return TextFormField(
			decoration: InputDecoration(
					labelText: 'Departamento', border: OutlineInputBorder()),
			validator: (value) => utils.formFieldIsNotEmpty(value),
			onSaved: (value) => _quotation.departamento = value,
		);
	}

	Widget _createDBFFCondicionesV() {
		return DropdownButtonFormField<String>(
			decoration: InputDecoration(
				border: OutlineInputBorder()
			),
			value: _condicionVentaSelec,
			items: _condicionesV.map(
				(String opt) => DropdownMenuItem(child: Text(opt), value: opt))
				.toList(),
			onChanged: (optSelec) => setState(() => _condicionVentaSelec = optSelec),
			validator: (value) => utils.dropDownIsValid(value),
			onSaved: (value) => _quotation.condicionesVenta = value,
		);
	}

	TextFormField _createTFFTiempoE() {
		return TextFormField(
			decoration: InputDecoration(
				labelText: 'Tiempo de entrega', border: OutlineInputBorder()
			),
			validator: (value) => utils.formFieldIsNotEmpty(value),
			onSaved: (value) => _quotation.tiempoEntrega = value,
		);
	}

	Align _createButton(BuildContext context) {
		return Align(
			alignment: Alignment.centerRight,
			child: TextButton.icon(
        icon: _sendingQuotation ? CircularProgressIndicator() : Container(),
				label: Text('Siguiente'),
				onPressed: () async {
          //* Indicar que el envío está en proceso.
          _sendingQuotation = true;

					//* Si hay algun error, no se ejecutan las lineas despues de esta
					//* condición. Es decir que no se guardan los datos del formulario.
					if (!_formKey.currentState.validate()) return;

					//* Ejecutar la propiedad 'save' de los elementos del formulario.
					_formKey.currentState.save();
					//? mostrar en consola los datos de la cotización recien creada.
					print(_quotation.toJson());

					//* Publicar en FireBase la cotización creada y
          //* asignar el ID a la cotización.
					_quotation.id = await _quotationService.createQuotation(_quotation);

					//* Dirigir a la pantalla para agregar productos a la cotización.
					Navigator.pushNamed(context, 'addProd', arguments: _quotation.id);
				}
			),
		);
	}

	void _createDatePicker(BuildContext context) async {
		//* Hacer que el TextFormField no tome el foco
		FocusScope.of(context).requestFocus(new FocusNode());

		//* Ejecutar el DatePicker
		DateTime date = await showDatePicker(
			context: context,
			initialDate: DateTime.now(),
			firstDate: DateTime(2018),
			lastDate: DateTime(2021)
		);

		//* Asignar la fecha seleccionada en el DatePicker al TextFormField
		if (date != null) {
			setState(() {
				//? Darle formato de dia/mes/año a la fecha obtenida del DatePicker
				//? y actualizar el valor de fecha en el producto.
				_quotation.fecha = DateFormat('dd/MM/yyyy').format(date);

				//? Asignar el valor al controlador del TextFormField
				_controllerDatePicker.text = _quotation.fecha;
			});
		}
	}

	//? Página 2: Consultar cotizaciones
	SliverPersistentHeader _createHeader() {
		return SliverPersistentHeader(
			delegate: HeaderDelegate(
				dropDownValue: _dropDownValuePage2,
				updateValue: _updateText
			),
			pinned: true
		);
	}

	SliverFillRemaining _createBody() {
		// TODO: Crear FTBuilder que muestre la lista de resultados,
		// todo: y poner este widget como initialData.
		//* Widget que extiende a su hijo en el area visible restante de la pantalla
		return SliverFillRemaining(
			hasScrollBody: false,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Icon(Icons.search_off, size: 200.0, color: Colors.grey),
					Text(
						'No hay búsquedas recientes',
						style: Theme.of(context).textTheme.subtitle2
					),
				],
			),
		);
		
		// TODO: Esto es lo que podría ir dentro del FTBuilder
		// return SliverList(
		// 	delegate: SliverChildListDelegate([
		//     SingleChildScrollView()
		//   ])
		// );
	}

	//* Utilidades
	void _updateText(String value) {
		setState(() {
			_dropDownValuePage2 = value;
		});
	}

}
