import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sistema_ochoa/src/Models/quotation_model.dart';

class QuotationProvider {
  final String _url = 'https://proyectoochoasc.firebaseio.com';

  Future<bool> crearProducto(QuotationModel product) async {
    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<QuotationModel>> obtenerProducto() async {
    List<QuotationModel> quotationList = new List<QuotationModel>();

    final url = '$_url/productos.json';

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return [];
  }
}
