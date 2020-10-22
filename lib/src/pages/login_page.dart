import 'package:flutter/material.dart';
import 'package:sistema_ochoa/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		//* MediaQuery
		//? Tamaños de la pantalla del dispositivo
		final size =MediaQuery.of(context).size;
		
		return Scaffold(
			body: Stack(
				children: [
					_backgroung(context, size),
					_front(context, size)
				]
			),
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

				Text(
          'Servicios Industriales Ochoa',
          style: TextStyle(
            color: Color.fromRGBO(127, 133, 137, 1.0),
            fontSize: 24.0,
            fontWeight: FontWeight.bold
          )
        )
			],
		);

		return Stack(
			children:[
				background,
				logo
			]
		);
	}

	Widget _front(BuildContext context, Size size) {
		//* Variable que permitirá el uso de las funciones BLOC
		final bloc = Provider.of(context);

		final title = Text(
			'Iniciar sesión',
			style: TextStyle(fontSize: 20.0),
		);

		final createPswdButton = Container(
			padding: EdgeInsets.only(right: 16.0),
			alignment: Alignment.centerRight,
			child: TextButton(
				child: Text('Olvidé mi contraseña'),
				onPressed: (){}
			),
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

								SizedBox(height: 10.0),

								createPswdButton,

								SizedBox(height: 30.0),

								createLoginButton(bloc),

								SizedBox(height: 30.0),

                createSignUp(context),

								SizedBox(height: 10.0),
							],
						),
					),

					SizedBox(height: size.height * 0.05)
				],
			)
		);

	}

	Widget createLoginButton(LoginBloc bloc) {
	  //* Propiedad para el ElevatedButton
		OutlinedBorder getBorderRadius(Set<MaterialState> states) {
			return RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0));
		}

		return StreamBuilder(
			stream: bloc.formValidStream,
			builder: (BuildContext context, AsyncSnapshot snapshot){

				return ElevatedButton(
					style: ButtonStyle(
						shape: MaterialStateProperty.resolveWith<OutlinedBorder>(getBorderRadius)
					),
					child: Text('Iniciar sesión'),

					onPressed: snapshot.hasData ?
						() => _login(context, bloc)
						:
						null,
				);

			},
		);
		
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
			builder: (BuildContext context, AsyncSnapshot snapshot){
				
				return Padding(
					padding: const EdgeInsets.symmetric(horizontal: 16.0),

					child: TextField(
						keyboardType: TextInputType.emailAddress,
						decoration: InputDecoration(
							icon: Icon(Icons.alternate_email),
							labelText: 'Correo electrónico',
							hintText: 'email@corporativo.com',
							counterText: snapshot.data,
							errorText: snapshot.error
						),

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
			builder: (BuildContext context, AsyncSnapshot snapshot){
			
				return Padding(
					padding: const EdgeInsets.symmetric(horizontal: 16.0),
					child: TextField(
						obscureText: true,
						decoration: InputDecoration(
							icon: Icon(Icons.lock),
							labelText: 'Contraseña',
							counterText: snapshot.data,
							errorText: snapshot.error
						),

						onChanged: bloc.changePassword,
					),
				);

			},
		);

	}

  _login(BuildContext context, LoginBloc bloc) {

    Navigator.pushReplacementNamed(context, 'home');

  }

  Widget createSignUp(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(right: 16.0),
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text('Crear una cuenta'),

        onPressed: () => Navigator.pushReplacementNamed(context, 'signup'),
      ),
    );
  }

}
