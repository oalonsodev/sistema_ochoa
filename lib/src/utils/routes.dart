import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/pages/cotizaciones/cot_productos_page.dart';
import 'package:sistema_ochoa/src/pages/home_page.dart';
import 'package:sistema_ochoa/src/pages/login_page.dart';
import 'package:sistema_ochoa/src/pages/sign_up_page.dart';

String initialRoute = 'addProd';

Map<String, WidgetBuilder> getRoutes() {
	return {
		'login' 	: (BuildContext context) => LoginPage(),
		'signup'	: (BuildContext context) => SignUpPage(),
		'home'  	: (BuildContext context) => Home(),
		'addProd'	: (BuildContext context) => ProductosCotPage(),
	};
}
