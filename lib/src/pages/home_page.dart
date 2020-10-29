import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/pages/ajustes_page.dart';
import 'package:sistema_ochoa/src/pages/catalogo_page.dart';
import 'package:sistema_ochoa/src/pages/clientes_page.dart';
import 'package:sistema_ochoa/src/pages/cotizaciones/cotizaciones_page.dart';
import 'package:sistema_ochoa/src/pages/proveedores_page.dart';

class Home extends StatefulWidget {
	const Home({Key key}) : super(key: key);

	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
	//* Variable para indicar la página seleccionada.
	int _currentIndex = 0;

	@override
	Widget build(BuildContext context) {
		
    return DefaultTabController(
      length: 2,
		  child: Scaffold(
		  	appBar: AppBar(
		  		title: Text('Sistema de cotizaciones'),
		  		centerTitle: true,
          bottom: _createTabBar()
        ),

		  	body: _pages(),

		  	bottomNavigationBar: _createBottomNavigationBar(),
		  ),
		);
	}

	PreferredSizeWidget _createTabBar() {
	  if (_currentIndex == 0) {
      return TabBar(
        tabs: [
          Tab(child: Text('Nueva cotización'),),
          Tab(child: Text('Consultar cotizaciones'),),
        ]
      );
    } else {
      return null;
    }
	}
  
  Widget _pages() {
    switch (_currentIndex) {
      case 0: return CotizacionesPage();

      case 1: return CatalogoPage();
        
      case 2: return ClientesPage();
        
      case 3: return ProveedoresPage();
        
      case 4: return AjustesPage();
        
      default: return CotizacionesPage();
    }
  }

	BottomNavigationBar _createBottomNavigationBar() => BottomNavigationBar(
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

	BottomNavigationBarItem _createBNBItem(IconData icon, String title) => BottomNavigationBarItem(
    icon: Icon(icon),
    label: title,
  );
  
}
