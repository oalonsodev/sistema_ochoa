import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sistema_ochoa/src/utils/utils.dart' as utils;
import 'package:sistema_ochoa/src/Models/ProductModel.dart';

class CotizacionesPage extends StatefulWidget {
  @override
  _CotizacionesPageState createState() => _CotizacionesPageState();
}

class _CotizacionesPageState extends State<CotizacionesPage> {
  //* Key del Widget Form
  final formKey = new GlobalKey<FormState>();

  //* Modelo de producto
  ProductModel product = new ProductModel();

  //* ======= PageOne ======= 
  //? Valores del formulario
 
  //? Controladores
  TextEditingController _controllerDatePicker = new TextEditingController();

  //* ======= /PageOne =======
  //* ======= PageTwo =======
    // TODO Variables y propiedades usadas en la segunda página del TabBarView

  //* ======= /PageTwo =======


  @override
  Widget build(BuildContext context) {
    //* Asignar valor inicial al TextFormField del DatePicker sin afectar a las
    //* asignaciones hechas desde el DatePicker.
    if ( utils.isToday(product.fecha) )
      _controllerDatePicker.text = product.fecha;

    return TabBarView(
      children: [
        _pageOne(context),
        Center(child: Text('data 2')),
      ]
    );
  }

  Widget _pageOne(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        
        child: Form(
          key: formKey,

          child: Column(
            children: [

              _createLabelDivider('Datos de cotización'),
              
              _createTFFDatePicker(context),
              
              _createSpace(16.0),
              
              _createTFFFolio(),
              
              _createSpace(16.0),
              
              _createTFFNoReq(),
              
              _createSpace(24.0),
              _createLabelDivider('Datos del cliente'),
              
              _createTFFCliente(),
              
              _createSpace(16.0),
              
              _createTFFDireccion(),
              
              _createSpace(16.0),
              
              _createTFFComprador(),
              
              _createSpace(16.0),
              
              _createTFFDepartamento(),
              
              _createSpace(24.0),
              _createLabelDivider('Otros datos'),
              
              _createTFFCondicionesV(),
              
              _createSpace(16.0),
              
              _createTFFTiempoE(),
              
              _createSpace(24.0),
              
              _createButton()

            ],
          ),
        ),
      ),
    );
  }

  TextFormField _createTFFDatePicker(BuildContext context) {
    return TextFormField(
      controller: _controllerDatePicker,
      decoration: InputDecoration(
        labelText: 'Fecha de solicitud',
        border: OutlineInputBorder()
      ),
      onTap: ()=> _createDatePicker(context),
      
      validator: (value) => utils.formFieldIsEmpty(value),
    );
  }

  TextFormField _createTFFFolio() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Folio de la cotización',
        border: OutlineInputBorder()
      ),
      onSaved: (value) => product.folio = value,
      
      validator: (value) => utils.formFieldIsEmpty(value),
    );
  }

  TextFormField _createTFFNoReq() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'No. de requisición',
        border: OutlineInputBorder()
      ),
      
      validator: (value) => utils.formFieldIsEmpty(value),
    );
  }

  TextFormField _createTFFCliente() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Cliente',
        border: OutlineInputBorder()
      ),
      
      validator: (value) => utils.formFieldIsEmpty(value),
    );
  }

  TextFormField _createTFFDireccion() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Dirección',
        border: OutlineInputBorder()
      ),
      
      validator: (value) => utils.formFieldIsEmpty(value),
    );
  }

  TextFormField _createTFFComprador() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Comprador',
        border: OutlineInputBorder()
      ),
      
      validator: (value) => utils.formFieldIsEmpty(value),
    );
  }

  TextFormField _createTFFDepartamento() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Departamento',
        border: OutlineInputBorder()
      ),
      
      validator: (value) => utils.formFieldIsEmpty(value),
    );
  }

  Widget _createTFFCondicionesV() {
    return Row(
      //* Coloca el espacio disponible entre los hijos
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text('Condiciones de venta:'),

        DropdownButton<String>(
          // isExpanded: true, //* Expande el DropdownB horizontalmente
          items: [
            DropdownMenuItem(child: Text('De contado'), ),
            DropdownMenuItem(child: Text('A crédito')),
            DropdownMenuItem(child: Text('50% de contado, 50% a crédito')),
          ],
          onChanged: (opt){},
        )
      ],
    );
    
  }

  TextFormField _createTFFTiempoE() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Tiempo de entrega',
        border: OutlineInputBorder()
      ),

      validator: (value) => utils.formFieldIsEmpty(value),
    );
  }

  Align _createButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text('Siguiente'),
        onPressed: (){
          formKey.currentState.validate();
        }
      ),
    );
  }






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

  void _createDatePicker(BuildContext context) async{
    //* Hacer que el TextFormField no tome el foco
    FocusScope.of(context).requestFocus(new FocusNode());

    //* Ejecutar el DatePicker
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2021)
    );

    //* Asignar la fecha seleccionada en el DatePicker al TextFormField
    if (date != null){
      setState(() {

        //? Darle formato de dia/mes/año a la fecha obtenida del DatePicker
        //? y actualizar el valor de fecha en el producto.
        product.fecha = DateFormat('dd/MM/yyyy').format(date);

        //? Asignar el valor al controlador del TextFormField
        _controllerDatePicker.text = product.fecha;

      });
    }

  }

}
