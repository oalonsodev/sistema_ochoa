import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sistema_ochoa/src/models/product_model.dart';

class ProductService {
  final String _url = 'https://proyectoochoasc.firebaseio.com';
  // List<String> productList;

  Future<String> createProducts(ProductModel product) async {
    final url = '$_url/product.json';

    final resp = await http.post(url, body: productModelToJson(product));
    final decodedData = json.decode(resp.body);
    
    print(decodedData);

    return decodedData["name"];
  }
}
