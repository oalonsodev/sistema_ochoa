import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/views/login_page.dart';
import 'package:sistema_ochoa/src/views/sign_up_page.dart';
import 'package:sistema_ochoa/src/views/home_page.dart';
import 'package:sistema_ochoa/src/views/cotizaciones/cot_productos_page.dart';
import 'package:sistema_ochoa/src/views/cotizaciones/sumary/sumary_page.dart';
import 'package:sistema_ochoa/src/views/cotizaciones/select_provider_page.dart';
import 'package:sistema_ochoa/src/views/cotizaciones/save_page.dart';

String initialRoute = 'SelecPro';

Map<String, WidgetBuilder> getRoutes() {
	return {
		'login' 	: (BuildContext context) => LoginPage(),
		'signup'	: (BuildContext context) => SignUpPage(),
		'home'  	: (BuildContext context) => Home(),
		'addProd'	: (BuildContext context) => ProductosCotPage(),
		'QuotSum'	: (BuildContext context) => QuotationSumaryPage(),
		'QuotSave': (BuildContext context) => SavePage(),
		'SelecPro': (BuildContext context) => SelectProviderPage(),
	};
}
