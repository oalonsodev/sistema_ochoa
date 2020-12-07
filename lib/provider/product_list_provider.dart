import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/Models/product_model.dart';

class ProductListProvider with ChangeNotifier {
	//* Lista de productos
	List<ProductModel> _productList = [new ProductModel()];

	//* Obtener la lista de productos.
	List<ProductModel> get getProductList {
		return _productList;
	}

	//* Agregar un producto a la lista.
	void addProduct() {
		_productList.add(new ProductModel());

		notifyListeners();
	}

	//* Remover un producto de la lista.
	void removeProduct(int index) {
		_productList.removeAt(index);

		notifyListeners();
	}

	//* Actualizar un producto de la lista.
	void updateProduct(
		int index, {
		int linea,
		String nombre,
		int noParte,
		String marca,
		String modelo,
		int cantidad,
		String unidad,
		String comentario,
		}) {
			if (linea 			!= null)	_productList[index].linea				= linea;
			if (nombre 			!= null)	_productList[index].nombre			= nombre;
			if (noParte 		!= null)	_productList[index].noParte			= noParte;
			if (marca 			!= null)	_productList[index].marca				= marca;
			if (modelo 			!= null)	_productList[index].modelo			= modelo;
			if (cantidad 		!= null)	_productList[index].cantidad 		= cantidad;
			if (unidad 			!= null)	_productList[index].unidad 			= unidad;
			if (comentario 	!= null)	_productList[index].comentario 	= comentario;

			notifyListeners();

			print('${_productList[index].toJson()}');
	}
}
