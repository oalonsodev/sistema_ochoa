import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		
		return Scaffold(
			body: Stack(
        children: [
          _backgroung(context),
          _front(context)
        ]
      ),
		);
	}

	Widget _backgroung(BuildContext context) {
		final size =MediaQuery.of(context).size;

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
          scale: 0.5,
        ),

        SizedBox(height: 10.0),

        Text('Servicios')
      ],
    );

		return Stack(
		  children:[
				background,
        logo
			]
		);
	}

  Widget _front(BuildContext context) {
    //* MediaQuery
    final size =MediaQuery.of(context).size;

    //* Propiedad para el ElevatedButton
    OutlinedBorder getBorderRadius(Set<MaterialState> states) {
      return RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0));
    }

    final title = Text(
      'Iniciar sesión',
      style: TextStyle(fontSize: 20.0),
    );

		final createEmail = Padding(
		  padding: const EdgeInsets.symmetric(horizontal: 16.0),
		  child: TextField(
		  	keyboardType: TextInputType.emailAddress,
		  	decoration: InputDecoration(
          icon: Icon(Icons.alternate_email),
		  		labelText: 'Correo electrónico',
          hintText: 'email@corporativo.com'
		  	),
		  ),
		);

		final createPassword = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.privacy_tip),
          labelText: 'Contraseña',
        ),
      ),
    );
		
    final createPswdButton = Container(
      padding: EdgeInsets.only(right: 16.0),
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text('Olvidé mi contraseña'),
        onPressed: (){}
      ),
    );

    final createLoginButton = ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(getBorderRadius)
      ),
      child: Text('Iniciar sesión'),
      onPressed: (){}
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

								createEmail,

                SizedBox(height: 30.0),

                createPassword,

                SizedBox(height: 30.0),

                createPswdButton,

                SizedBox(height: 30.0),

                createLoginButton,

                SizedBox(height: 30.0),

							],
						),
					),

          SizedBox(height: size.height * 0.05)
				],
			)
		);
	}
}
