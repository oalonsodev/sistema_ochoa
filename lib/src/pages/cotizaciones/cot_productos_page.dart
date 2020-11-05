import 'package:flutter/material.dart';

//TODO: Crear variables que controlen cada uno de los elementos señalados
//todo: para poder realizar la generación de más tabs.

//TODO: Crear y trabajar con el modelo de productos. HAcer una lista de
//todo: productos y en base a ella controlar la cantidad de tabs y los datos de
//todo: cada unaaaaaaaa :D

class ProductosCot extends StatefulWidget {
  @override
  _ProductosCotState createState() => _ProductosCotState();
}

class _ProductosCotState extends State<ProductosCot> {
  //? Sustituir depues por la lista de productos :D
  List<String> _tabList; //* Lista de productos

  @override
  void initState() {
    // TODO: implement initState
    _tabList = ['1']; //* El primer valor de la lista
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Agregar productos'),
          bottom: _createTabBar(),
        ),
        body: _createTabBarView(),
        floatingActionButton: _createFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        persistentFooterButtons: _createPersistantFooterButtons(),
      ),
    );
  }

  TabBar _createTabBar() {
    return TabBar(
			isScrollable: true,
      tabs: _tabList.map((String pos) {
        return Tab(text: 'Linea $pos');
      }).toList(),
    );
  }

  TabBarView _createTabBarView() {
    return TabBarView(
      children: _tabList.map((String pos) {
        return Tab(text: 'Linea $pos');
      }).toList(),
    );
  }

  Row _createFloatingActionButton() {
		var _floatingActionButton;

		(_tabList.length > 1) ? 
			_floatingActionButton = FloatingActionButton(
				child: Icon(Icons.clear),
				onPressed: (){
					setState(() => _tabList.removeLast());
				}
			)
		:
			_floatingActionButton = SizedBox();

    return Row(
      children: [
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
						//* Cuando se agrega el 2do valor a la lista, la longitud sigue
						//* siendo 1, por lo que el 2do valor repite el valor '1'. Por
						//* eso se agrega el +1, para compensar esa falta.
            setState(() => _tabList.add('${_tabList.length+1}'));
						//* Para este momento de la ejecución el nuevo valor ya fue agregado
						//* a la lista, por lo que la longitud concuerda con lo escrito en
						//* el último valor.
          },
        ),
				SizedBox(width: 16.0),
				_floatingActionButton
      ],
    );
  }

  _createPersistantFooterButtons() {
    return <Widget>[
      TextButton(child: Text('Cancelar'), onPressed: () {}),
      ElevatedButton(child: Text('Siguiente'), onPressed: () {})
    ];
  }
}
