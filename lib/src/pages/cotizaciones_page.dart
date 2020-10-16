import 'package:flutter/material.dart';

class CotizacionesPage extends StatefulWidget {
  @override
  _CotizacionesPageState createState() => _CotizacionesPageState();
}

class _CotizacionesPageState extends State<CotizacionesPage> {
  
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        _pageOne(),
        Center(child: Text('data 2')),
      ]
    );
  }

  Widget _pageOne() => ListView(
    shrinkWrap: true, //* Indica si la lista debe ajustarse a sus hijos
    padding: EdgeInsets.all(16.0),
    children: [
      _createLabelDivider('Datos de cotización'),
      TextField(
        decoration: InputDecoration(
          labelText: 'Fecha de solicitud',
          border: OutlineInputBorder()
        ),
      ),
      _createSpace(8.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Folio de la cotización',
          border: OutlineInputBorder()
        ),
      ),
      _createSpace(8.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'No. de requisición',
          border: OutlineInputBorder()
        ),
      ),
      _createSpace(24.0),
      _createLabelDivider('Datos del cliente'),
      TextField(
        decoration: InputDecoration(
          labelText: 'Cliente',
          border: OutlineInputBorder()
        ),
      ),
      _createSpace(8.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Dirección',
          border: OutlineInputBorder()
        ),
      ),
      _createSpace(8.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Comprador',
          border: OutlineInputBorder()
        ),
      ),
      _createSpace(8.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Departamento',
          border: OutlineInputBorder()
        ),
      ),
      _createSpace(24.0),
      _createLabelDivider('Otros datos'),
      DropdownButton<String>(
        
        isExpanded: true, //* Expande el DropdownB horizontalmente
        items: [
          DropdownMenuItem(child: Text('De contado'), ),
          DropdownMenuItem(child: Text('A crédito')),
          DropdownMenuItem(child: Text('50% de contado, 50% a crédito')),
        ],
        onChanged: (s){},
      ),
      _createSpace(8.0),
      TextField(
        decoration: InputDecoration(
          labelText: 'Tiempo de entrega',
          border: OutlineInputBorder()
        ),
      ),
      _createSpace(24.0),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          child: Text('Siguiente'),
          onPressed: (){}
        ),
      )
    ],
    
  );

  Widget _createLabelDivider(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Divider(thickness: 1.0, color: Theme.of(context).primaryColor)
      ],
    );
  }

  Widget _createSpace(double height) => SizedBox(height: height);
}
