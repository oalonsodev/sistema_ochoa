import 'package:flutter/material.dart';
import 'package:sistema_ochoa/src/bloc/login_bloc.dart';
export 'package:sistema_ochoa/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget {
  //* Implementación de un patrón singleton para mantener la inf.
  //* cuando ya existe una instancia de nuestra clase Provider.
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null)
      return _instancia = new Provider._internal(key: key, child: child);
    else
      return _instancia;
  }
  
  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);

  final loginBloc = LoginBloc();


  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBloc;
}
