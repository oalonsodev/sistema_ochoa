import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sistema_ochoa/src/models/provider_model.dart';

class ProviderService {
	final String _url = 'https://proyectoochoasc.firebaseio.com';

	Future<String> createProvider(ProviderModel provider) async {
    final url = '$_url/provider.json';

    final resp = await http.post(url, body: providerModelToJson(provider));
    final decodedData = json.decode(resp.body);
    
    print(decodedData);
		
    return decodedData["name"];
  }
}