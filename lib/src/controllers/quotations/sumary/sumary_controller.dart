import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sistema_ochoa/provider/product_form_provider.dart';
import 'package:sistema_ochoa/provider/product_list_provider.dart';
import 'package:sistema_ochoa/provider/quotation_provider.dart';

import 'package:sistema_ochoa/src/services/product_service.dart';
import 'package:sistema_ochoa/src/services/quotation_service.dart';

import 'package:sistema_ochoa/src/models/product_model.dart';

mixin QuotationSumaryController {
	//* ======= Variables =======
	//? => Servicios
	/// Proveedor de métodos para los procesos REST de cotizaciones
	QuotationService quotationService;
	ProductService productService;

	//? => Providers
	/// Proveedor de la cotización actual.
	QuotationProvider quotationProvider;
	/// Proveedor de productos
	ProductListProvider productProvider;
  // TODO: Eliminar
  /// El FormProvider se utiliza hasta que haya que eliminar la lista.
	// /// Provedor de GlobalKeys
	// ProductFormProvider formProvider;

	//? => Stilos de textos
	/// Estilo para el nombre de los productos.
	TextStyle title;
	/// Estilo para los títulos de las propiedades.
	TextStyle property;
	/// Estilo para las propiedades de los productos.
	TextStyle value;

	//* ======= Métodos =======
	/// Inicializa los servicio a utilizar
	void initServices() {
		quotationService = new QuotationService();
		productService = new ProductService();
	}

	/// Inicializar proveedor de la cotización.
	void initQuotation(BuildContext context) {
		quotationProvider = Provider.of(context);
	}

	/// Inicializar provedor de productos.
	void initProducts(BuildContext context) {
		productProvider = Provider.of(context);
	}

	/// Inicializar estilos de títulos.
	void initStyles(BuildContext context) {
		title = Theme.of(context).textTheme.headline6;
		property = Theme.of(context).textTheme.subtitle1;
		value = Theme.of(context).textTheme.subtitle2;
	}

	Widget createTitle(String title) {
		return Text(title, style: this.title);
	}

	/// Crea las propiedades a mostrar de la cotización.
	List<Widget> createQuotationProperties() {
		return [
			Row( children: [
				Text('Cliente: ', style: property),
				Text(
					'${quotationProvider.quotation.cliente}',
					style: value,
				)
			]),
			Row( children: [
				Text('Folio: ', style: property),
				Text(
					'${quotationProvider.quotation.folio}',
					style: value,
				)
			]),
			Row( children: [
				Text('No. de requisión: ', style: property),
				Text(
					'${quotationProvider.quotation.noReq}',
					style: value,
				)
			]),
			Row( children: [
				Text('Costo total: ', style: property),
				Text(
					'${quotationProvider.quotation.costoTot}',
					style: value,
				)
			]),
			Text('Productos:', style: property)
		];
	}

	/// Crea las propiedades a mostrar en las tarjetas de producto.
	List<Widget> createProductProperties(int index) {
		return [
			Row( children: [
				Text(
					'${productProvider.getProductList[index].nombre}',
					style: title
				)
			]),
			SizedBox(height: 8.0),
			Row( children: [
				Text('No. de parte: ', style: property),
				Text(
					'${productProvider.getProductList[index].noParte}',
					style: value
				)
			]),
			SizedBox(height: 8.0),
			Row( children: [
				Text('Cantidad: ', style: property),
				Text(
					'${productProvider.getProductList[index].cantidad}',
					style: value
				)
			]),
			SizedBox(height: 8.0),
			Row( children: [
				Text('Comentario: ', style: property),
				Text(
					'${productProvider.getProductList[index].comentario}',
					style: value
				)
			])
		];
	}

	/// Publicar en linea los productos de la cotización.
	Future saveProducts() async {
		//? Publicar los productos en linea.
			for (ProductModel product in productProvider.getProductList) {
				product.id = await productService.createProducts(product);
			}

			// TODO: Mover de lugar.
			/// Las siguientes lineas deben ejecutarse hasta que el proceso
			/// finalice por completo, ya sea en la pantalla
			/// 'Datos guardados' o 'Solicitud en proceso' en el botón 'finalizar'
			// //? Vaciar la lista de productos local.
			// productProvider.clearList();
			
			// //? Vaciar la lista de llaves locales.
			// formProvider.clearList();

			// //? Restaurar la cotización
			// quotationProvider.resetQuotation();

	}

	/// Publicar en linea los datos de la cotización.
	Future saveQuotation() async {
		for (var i = 0; i < productProvider.getProductList.length; i++) {
			quotationProvider.quotation.productos.add(
        productProvider.getProductList[i].id
      );
		}

		print(quotationProvider.quotation.toJson());

		quotationProvider.quotation.id
			= await quotationService.createQuotation(quotationProvider.quotation);
	}
}
