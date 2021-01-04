import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/controllers/quotations/select_provider/select_provider_controller.dart';

class SelectProviderPage extends StatefulWidget {
  @override
  _SelectProviderPageState createState() => _SelectProviderPageState();
}

class _SelectProviderPageState extends State<SelectProviderPage>
    with SelectProviderController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _createFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      persistentFooterButtons: _persistentFooterButtons(),
    );
  }

  Widget _appBar() {
    return AppBar(title: Text('Elegir proveedores'), centerTitle: true);
  }

  Widget _body() {
    //TODO: Pendiente
    /// Agregar una condición que muestre el elemento que será visible cuando
    /// no hayan proveedores registrados, o la lista cuando sí haya.
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        addChek();
        return CheckboxListTile(
          secondary: Icon(Icons.account_circle, size: 56.0),
          title: Text('title'),
          subtitle: Text('subtitle'),
          value: checkList[index],
          onChanged: (value) => setState(() => checkList[index] = value),
        );
      },
    );
  }

  Widget _createFAB() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {},
    );
  }

  List<Widget> _persistentFooterButtons() {
    return [
      ElevatedButton(
        child: Text('Solicitar cotización'),
        onPressed: () {},
      )
    ];
  }
}
