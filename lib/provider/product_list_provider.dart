import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/models/product_model.dart';

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
	}

	//* Remover un producto de la lista.
	void removeProduct(int index) {
		_productList.removeAt(index);
	}

	/// Limpiar la lista de productos.
	/// -
	/// Este método se encarga de volver a tener un solo producto
	/// en la lista.  
	/// El producto estará vacío.
	void clearList() {
		_productList.clear();
		addProduct();
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
		String moneda,
		double precio,
		}) {
			if (linea 			!= null)	_productList[index].linea				= linea;
			if (nombre 			!= null)	_productList[index].nombre			= nombre;
			if (noParte 		!= null)	_productList[index].noParte			= noParte;
			if (marca 			!= null)	_productList[index].marca				= marca;
			if (modelo 			!= null)	_productList[index].modelo			= modelo;
			if (cantidad 		!= null)	_productList[index].cantidad 		= cantidad;
			if (unidad 			!= null)	_productList[index].unidad 			= unidad;
			if (comentario 	!= null)	_productList[index].comentario 	= comentario;
			if (moneda     	!= null)	_productList[index].moneda 	    = moneda;
			if (precio     	!= null)	_productList[index].precio 	    = precio;

			print('${_productList[index].toJson()}');
	}
}
