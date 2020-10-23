import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProvider {
	
	final String _fireBaseKey = 'AIzaSyDx2YClrO9l000W3fDg_T09extn3HhuWzk';

	Future<Map<String, dynamic>> login(String email, String password) async{
		final authData = {
			'email'			:	email,
			'password'	:	password,
			'returnSecureToken'	:	true
		};

		final resp = await http.post(
			'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_fireBaseKey',
			body: json.encode(authData)
		);

		Map<String, dynamic> decodedResp = json.decode(resp.body);

		print(decodedResp);

		if (decodedResp.containsKey('idToken')) {
			//TODO: salvar el token en el storage
			return {'ok': true, 'idToken' : decodedResp['idToken']};

		} else {
			//TODO: Devolver un mensaje de error
			return {'ok': false, 'message' : decodedResp['error']['message']};
		}

	}

	Future<Map<String, dynamic>> newUser(String email, String password) async {
		final authData = {
			'email'			:	email,
			'password'	:	password,
			'returnSecureToken'	:	true
		};

		final resp = await http.post(
			'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_fireBaseKey',
			body: json.encode(authData)
		);

		Map<String,dynamic> decodedResp = json.decode(resp.body);

		print(decodedResp);

		if (decodedResp.containsKey('idToken')) {
			//TODO: salvar el token en el storage
			return {'ok': true, 'idToken' : decodedResp['idToken']};

		} else {
			//TODO: Devolver un mensaje de error
			return {'ok': false, 'message' : decodedResp['message']};
		}

	}

}