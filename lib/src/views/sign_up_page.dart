import 'package:flutter/material.dart';
import 'package:sistema_ochoa/src/bloc/provider.dart';
import 'package:sistema_ochoa/src/services/user_provider.dart';
import 'package:sistema_ochoa/src/utils/utils.dart' as utils;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final userProvider = new UserProvider();

  //* Controladores para mantener en los TextFiels el ultimo valor ingresado
  //* (La otra opciones era quitar el patrón singleton que mantenía el
  //* último dato ingresado por el usuario)
  final emailController = new TextEditingController();

  final passwordController = new TextEditingController();

  //* Variable para controlar la animación de ingreso.
  bool wasPressed = false;
  double opacityButtom = 1.0, opacityProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    //* MediaQuery
    //? Tamaños de la pantalla del dispositivo
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body:
          Stack(children: [_backgroung(context, size), _front(context, size)]),
    );
  }

  Widget _backgroung(BuildContext context, Size size) {
    final background = Container(
      height: double.infinity,
      child: Image.asset(
        'lib/src/img/login-bg.jpg',
        fit: BoxFit.cover,
      ),
    );

    final logo = Column(
      children: [
        SizedBox(height: size.height * 0.1, width: double.infinity),
        Image.asset(
          'lib/src/img/logo.png',
          fit: BoxFit.cover,
          scale: 0.75,
        ),
        SizedBox(height: 10.0),
        Text('Servicios Industriales Ochoa',
            style: TextStyle(
                color: Color.fromRGBO(127, 133, 137, 1.0),
                fontSize: 24.0,
                fontWeight: FontWeight.bold))
      ],
    );

    return Stack(children: [background, logo]);
  }

  Widget _front(BuildContext context, Size size) {
    //* Variable que permitirá el uso de las funciones BLOC
    final bloc = Provider.of(context);

    //* Establecimiento de los últimos valores ingresados para mostrarlos en los
    //* TextFields al redibujar.
    emailController.text = bloc.emailValue;
    passwordController.text = bloc.passwordValue;

    final title = Text(
      'Crear una cuenta',
      style: TextStyle(fontSize: 20.0),
    );

    return SingleChildScrollView(
        child: Column(
      children: [
        SafeArea(child: Container(height: size.height * 0.3)),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(height: 30.0),
              title,
              SizedBox(height: 60.0),
              createEmail(bloc),
              SizedBox(height: 30.0),
              createPassword(bloc),
              SizedBox(height: 60.0),
              createSingUpButton(bloc),
              SizedBox(height: 30.0),
              createRegister(context),
              SizedBox(height: 10.0),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.05)
      ],
    ));
  }

  Widget createEmail(LoginBloc bloc) {
    //* ¿Cómo funciona este STBuilder?
    //* El Textield le manda información con cada cambio mediante el
    //* 'bloc.changeEmail'. Esta información es escuchada por el Stream
    //* pues está conectado al StreamController 'bloc.emailStream'.
    //* Esta info. puede ser ahora usada mediante el snapshot.
    //? Viene siendo un circulito:
    //? (escucha mediante bloc.changeEmail, y retorna mediante bloc.emailStream)
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email),
                labelText: 'Correo electrónico',
                hintText: 'email@corporativo.com',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget createPassword(LoginBloc bloc) {
    //* ¿Cómo funciona este STBuilder?
    //* El Textield le manda información con cada cambio mediante el
    //* 'bloc.changePassword'. Esta información es escuchada por el Stream
    //* pues está conectado al StreamController 'bloc.PasswordStream'.
    //* Esta info. puede ser ahora usada mediante el snapshot.
    //? Viene siendo un circulito:
    //? (escucha mediante bloc.changePassword, y retorna mediante bloc.PasswordStream)
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget createSingUpButton(LoginBloc bloc) {
    //* Propiedad para el ElevatedButton
    OutlinedBorder getBorderRadius(Set<MaterialState> states) {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0));
    }

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        return Stack(
          alignment: Alignment.center,
          children: [

            AnimatedOpacity(
              duration: Duration(milliseconds: 1000),
              opacity: opacityProgress,
              child: CircularProgressIndicator()
            ),
            
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: opacityButtom,
              child: ElevatedButton(
                child: Text('Registrarse'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(getBorderRadius)
                ),
                onPressed: snapshot.hasData ? () => _signUp(context, bloc) : null,
              ),
            ),

          ] 
        );

      },
    );
  }

  void _signUp(BuildContext context, LoginBloc bloc) async {
    wasPressed = true;

    if (wasPressed) {
      setState(() {
        opacityButtom = 0.0;
        opacityProgress = 1.0;
      });
    }

    Map<String, dynamic> info =
        await userProvider.newUser(bloc.emailValue, bloc.passwordValue);

    if (info['ok'] == true) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      setState(() {
        opacityButtom = 1.0; 
        opacityProgress = 0.0; 
			  wasPressed = false;
			});
      utils.showError(context, info['message']);
    }
  }

  Widget createRegister(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('¿Ya tiene una cuenta?'),
          TextButton(
            child: Text('Inicie sesión'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
        ],
      ),
    );
  }
}
