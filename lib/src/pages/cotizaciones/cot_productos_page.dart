import 'package:flutter/material.dart';

//TODO: Crear variables que controlen cada uno de los elementos señalados
//todo: para poder realizar la generación de más tabs.

class ProductosCot extends StatefulWidget {
  @override
  _ProductosCotState createState() => _ProductosCotState();
}

class _ProductosCotState extends State<ProductosCot> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1, //? <------------------------
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
    return TabBar(tabs: <Widget>[
      //? <------------------------
      Tab(text: 'Linea 1'),
      // Tab(text: 'Linea 2')
    ]);
  }

  TabBarView _createTabBarView() {
    return TabBarView(children: <Widget>[
      //? <------------------------
      Container(color: Colors.green[300]),
      // Container(color: Colors.blue)
    ]);
  }

  FloatingActionButton _createFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){},
    );
  }

  _createPersistantFooterButtons() {
    return <Widget>[
      TextButton(child: Text('Cancelar'), onPressed: () {}),
      ElevatedButton(child: Text('Siguiente'), onPressed: () {})
    ];
  }
}
