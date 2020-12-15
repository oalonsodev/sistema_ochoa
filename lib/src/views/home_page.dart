import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/views/ajustes_page.dart';
import 'package:sistema_ochoa/src/views/catalogo/catalogo_page.dart';
import 'package:sistema_ochoa/src/views/clientes/clientes_page.dart';
import 'package:sistema_ochoa/src/views/cotizaciones/cotizaciones_page.dart';
import 'package:sistema_ochoa/src/views/proveedores/proveedores_page.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //* Variable para indicar la página seleccionada.
  int _currentIndex;
  String _title;

  @override
  void initState() {
    // TODO: implement initState
    _currentIndex = 0;
    _title = 'Cotizaciones';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _changeTitle();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          centerTitle: true,
          bottom: _createTabBar()
        ),
        body: _pages(),
        bottomNavigationBar: _createBottomNavigationBar(),
      ),
    );
  }

  PreferredSizeWidget _createTabBar() {
    return _currentIndex == 0
			? TabBar(tabs: [
					Tab(
						child: Text('Nueva cotización'),
					),
					Tab(
						child: Text('Consultar cotizaciones'),
					),
				])
			: null;
  }

  Widget _pages() {
    switch (_currentIndex) {
      case 0:
        return CotizacionesPage();

      case 1:
        return CatalogoPage();

      case 2:
        return ClientesPage();

      case 3:
        return ProveedoresPage();

      case 4:
        return AjustesPage();

      default:
        return CotizacionesPage();
    }
  }

  BottomNavigationBar _createBottomNavigationBar() {
    return BottomNavigationBar(
		//* La propiedad currentIndex indica la opción seleccionada.
		currentIndex: _currentIndex,
		onTap: (index) {
			//* Cada vez que se preciona una opción, el valor index
			//* cambia. A su vez, la variable _currentIndex es
			//* igualada a ese valor.
			setState(() {
				_currentIndex = index;
			});
		},

		//? Si hay 3 o menos íconos:
		//* - el BottomNavigationBarType = BottomNavigationBarType.fixed
		//*   (El espacio para cada boton es igual)
		//? Si hay 4 o más íconos:
		//* - el BottomNavigationBarType = BottomNavigationBarType.shifting
		//*   (El espacio del botón selec. es mayor al de los demás)
		//* - Hay que indicar las siguientes propiedades:
		//*     - BottomNavigationBar.selectedItemColor
		//*     - BottomNavigationBar.unselectedItemColor
		//*     - BottomNavigationBarItem.backgroundColor (opcional)
		//!     Si no se indican, los botones y el fondo tendrán el mismo color
		//!     Lo que hará que los botones desaparescan.

		selectedItemColor: Theme.of(context).accentColor,
		unselectedItemColor: Theme.of(context).unselectedWidgetColor,
		items: [
			_createBNBItem(Icons.note_add, 'Cotizaciones'),
			_createBNBItem(Icons.view_list, 'Catálogo'),
			_createBNBItem(Icons.account_circle, 'Clientes'),
			_createBNBItem(Icons.contact_mail, 'Proveedores'),
			_createBNBItem(Icons.build, 'Ajustes'),
		]
	);
  }

  BottomNavigationBarItem _createBNBItem(IconData icon, String title) {
    return BottomNavigationBarItem(
			icon: Icon(icon),
			label: title,
		);
  }

  void _changeTitle() {
		switch (_currentIndex) {
      case 0:
        _title = 'Cotizaciones';
        break;
      case 1:
        _title = 'Catálogo';
				break;
      case 2:
        _title = 'Clientes';
				break;
      case 3:
        _title = 'Proveedores';
				break;
      case 4:
        _title = 'Ajustes';
				break;
      default:
        _title = 'Cotizaciones';
    }
	}

}
