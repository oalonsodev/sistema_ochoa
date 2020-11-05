import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sistema_ochoa/src/utils/app_theme.dart';
import 'package:sistema_ochoa/src/utils/routes.dart' as routes;

import 'package:sistema_ochoa/src/bloc/provider.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Provider(

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
      )
    );

  }
}