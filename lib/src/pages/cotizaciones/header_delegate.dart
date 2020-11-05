import 'package:flutter/material.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  
  HeaderDelegate({this.dropDownValue, this.updateValue});

  String dropDownValue;
  final void Function(String value) updateValue;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
    padding: EdgeInsets.all(16.0),
    color: Theme.of(context).canvasColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Buscar mediante:'),
            DropdownButton(
              value: dropDownValue,
              items: <String>[
                'No. de folio',
                'Fecha de requisición',
                'Fecha de cotización',
                'Cliente', 'No. de parte'
              ]
              .map((item) => DropdownMenuItem(child: Text(item), value: item))
              .toList(),
              onChanged: (String value) => updateValue(value)
            )
          ],
        ),

        SizedBox(height: 16.0),

        TextField(
          decoration: InputDecoration(
            labelText: 'Código de búsqueda',
            border: OutlineInputBorder(),
          ),
        ),

        SizedBox(height: 24.0),
        
        Text('Búsquedas recientes:')
      ],

    ),
  );
  }
  
  @override
  //* Este número debe ser menor o igual a la altura del widget dibujado en el build
  double get maxExtent => 200.0;

  @override
  //* Este número debe ser menor o igual a la altura del widget dibujado en el build
  double get minExtent => 200.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate)
  => true;

}