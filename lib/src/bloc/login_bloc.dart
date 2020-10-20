import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:sistema_ochoa/src/bloc/validators.dart';

class LoginBloc with Validators {
  //* StreamControllers
  //? Del TextField 'email'
  final _emailController = BehaviorSubject<String>();

  //? Del TextField 'password'
  final _passwordController = BehaviorSubject<String>();

  //? Del Button 'login'
  Stream<bool> get formValidStream => CombineLatestStream.combine2(
      emailStream, passwordStream, (email, password) => true);
  
  //* Métodos Get para usar los controladores externamente
  //? Recuperar (o escuchar) datos de los Streams
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  //? Recuperar el último valor ingresador a los Streams
  String get emailValue => _emailController.value;

  String get passwordValue => _passwordController.value;


  //? Insertar valores a los Streams
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //* Método para cerrar los streams
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
