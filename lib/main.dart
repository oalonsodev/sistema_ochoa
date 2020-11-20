import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as global;
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sistema_ochoa/provider/product_form_provider.dart';
import 'package:sistema_ochoa/provider/product_list_provider.dart';
import 'package:sistema_ochoa/src/bloc/provider.dart';

import 'package:sistema_ochoa/src/utils/app_theme.dart';
import 'package:sistema_ochoa/src/utils/routes.dart' as routes;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Provider(

			child: global.MultiProvider(
				providers: [
					global.ChangeNotifierProvider(create: (context) => ProductListProvider()),
					global.ChangeNotifierProvider(create: (context) => ProductFormProvider()),
				],

				child: MaterialApp(
					localizationsDelegates: [
						GlobalMaterialLocalizations.delegate,
						GlobalWidgetsLocalizations.delegate,
						GlobalCupertinoLocalizations.delegate,
					],
					supportedLocales: [
						const Locale('es', 'ES'),
						const Locale('en', 'US')
					],

					debugShowCheckedModeBanner: false,
					title: 'Material App',
					
					initialRoute: routes.initialRoute,
					routes: routes.getRoutes(),

					theme: appTheme(),
				),
			)
		);

	}
}