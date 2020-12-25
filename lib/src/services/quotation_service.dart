import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sistema_ochoa/src/models/quotation_model.dart';

class QuotationService {
	final String _url = 'https://proyectoochoasc.firebaseio.com';
	String id;

	Future<String> createQuotation(QuotationModel quotation) async {
		final url = '$_url/quotation.json';
		final resp = await http.post(url, body: quotationModelToJson(quotation));
		final decodedData = json.decode(resp.body);

		id = decodedData['name'];

		return id;
	}

	Future<List<QuotationModel>> getQuotations() async {
		List<QuotationModel> quotationList = new List<QuotationModel>();

		final url = '$_url/quotation.json';

		final resp = await http.get(url);

		final decodedData = json.decode(resp.body);

		print(decodedData);

		return [];
	}
}
