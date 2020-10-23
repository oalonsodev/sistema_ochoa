import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sistema_ochoa/src/Models/ProductModel.dart';

class ProductsProvider {

  final String _url = 'https://proyectoochoasc.firebaseio.com';

  Future<bool> crearProducto( ProductModel product) async {
    
    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;

  }

  Future<List<ProductModel>> obtenerProducto() async {

    List<ProductModel> productList = new List<ProductModel>();

    final url = '$_url/productos.json';

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    print(decodedData);


  }

}
