import 'package:flutter/material.dart';

ThemeData appTheme(){

	return ThemeData(
		primaryColor: Colors.indigo,
		accentColor: Colors.indigo,
		elevatedButtonTheme: ElevatedButtonThemeData(
			style: ButtonStyle(
				backgroundColor: MaterialStateProperty.all(Colors.indigo)
			)
		),
		textButtonTheme: TextButtonThemeData(
			style: ButtonStyle(
				foregroundColor: MaterialStateProperty.all(Colors.indigo)
			)
		),
		iconTheme: IconThemeData(
			color: Colors.indigo,
		)
	);
}
