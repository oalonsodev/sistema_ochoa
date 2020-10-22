import 'package:flutter/material.dart';

class CotizacionesPage extends StatefulWidget {
  @override
  _CotizacionesPageState createState() => _CotizacionesPageState();
}

class _CotizacionesPageState extends State<CotizacionesPage> {
  //* PageOne
  //? Valores del formulario
  String _fecha = '';

  //? Controladores
  TextEditingController _controllerDate = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        _pageOne(context),
        Center(child: Text('data 2')),
      ]
    );
  }

  Widget _pageOne(BuildContext context) => SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(16.0),
      
      child: Form(
        child: Column(
          children: [

            _createLabelDivider('Datos de cotización'),
            TextFormField(
              controller: _controllerDate,
              decoration: InputDecoration(
                labelText: 'Fecha de solicitud',
                border: OutlineInputBorder()
              ),
              onTap: ()=> _createDatePicker(context),
            ),
            _createSpace(8.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Folio de la cotización',
                border: OutlineInputBorder()
              ),
            ),
            _createSpace(8.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'No. de requisición',
                border: OutlineInputBorder()
              ),
            ),
            _createSpace(24.0),
            _createLabelDivider('Datos del cliente'),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Cliente',
                border: OutlineInputBorder()
              ),
            ),
            _createSpace(8.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Dirección',
                border: OutlineInputBorder()
              ),
            ),
            _createSpace(8.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Comprador',
                border: OutlineInputBorder()
              ),
            ),
            _createSpace(8.0),
            TextFormField(
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
              onChanged: (opt){},
            ),
            _createSpace(8.0),
            TextFormField(
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
        ),
      ),
    ),
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

  _createDatePicker(BuildContext context) async{

    FocusScope.of(context).requestFocus(new FocusNode());

    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2021)
    );

    if (date != null){
      setState(() {
        _fecha = date.toString().substring(0, 10);
        _controllerDate.text = _fecha;
        print(_controllerDate.value);
      });
    }

  }

}
