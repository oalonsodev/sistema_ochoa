import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sistema_ochoa/src/bloc/provider.dart';
import 'package:sistema_ochoa/src/pages/cotizaciones/cot_productos_page.dart';
import 'package:sistema_ochoa/src/pages/home_page.dart';
import 'package:sistema_ochoa/src/pages/login_page.dart';
import 'package:sistema_ochoa/src/pages/sign_up_page.dart';
 
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
        
        initialRoute: 'addProd',
        routes: {
          'login'   : (BuildContext context) => LoginPage(),
          'signup'  : (BuildContext context) => SignUpPage(),
          'home'    : (BuildContext context) => Home(),
          'addProd' : (BuildContext context) => ProductosCot(),
        },

        theme: ThemeData(
          primaryColor: Colors.indigo,
        ),
      )
    );

  }
}