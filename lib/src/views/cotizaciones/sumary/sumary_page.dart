import 'package:flutter/material.dart';
import 'package:sistema_ochoa/src/controllers/quotations/sumary/sumary_controller.dart';

import 'header_delegate.dart';

class QuotationSumaryPage extends StatefulWidget {
  const QuotationSumaryPage({Key key}) : super(key: key);

  @override
  _QuotationSumaryPageState createState() => _QuotationSumaryPageState();
}

class _QuotationSumaryPageState extends State<QuotationSumaryPage>
    with QuotationSumaryController {
  
  @override
  void initState() { 
    super.initState();
    initServices();
  }

  @override
  void dispose() {
    productProvider.dispose();
    quotationProvider.dispose();
    super.dispose();
  }

  @override
  Widget build( BuildContext context ) {
    initProducts( context );
    initQuotation( context );
    initStyles( context );

    return Scaffold(
      appBar: _appBar(),
      body: CustomScrollView(
        slivers: [_header(), _body()],
      ),
      persistentFooterButtons: _createPersistentFooterButtons( context ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(title: Text('Resumen de solicitud'), centerTitle: true);
  }

  SliverPersistentHeader _header() {
    return SliverPersistentHeader(delegate: HeaderDelegate(), pinned: true);
  }

  // TODO: Pendiente
  /// Sustituir los Strings por los valores de los productos.
  SliverList _body() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        ( BuildContext context, int index ) {
          return Card(
            margin: EdgeInsets.symmetric( vertical: 8.0, horizontal: 25.0 ),
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular( 10.0 )
            ),
            child: Container(
              padding: EdgeInsets.all( 16.0 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: createProductProperties( index )
              ),
            )
          );
        },
        childCount: productProvider.getProductList.length ?? 1,
      )
    );
  }

  List<Widget> _createPersistentFooterButtons( BuildContext context ) {
    return [
      TextButton(
        child: Text('Guardar'),
        onPressed: () {
          saveProducts().then( (value) => saveQuotation() );
          nextRoute = 'QuotSave';
          savePageAction = 'Save';
          nextPage( context );
        },
      ),
      ElevatedButton(
        child: Text('Guardar y cotizar'),
        onPressed: () {
          saveProducts().then( (value) => saveQuotation() );
          nextRoute = 'SelectProviderPage';
          nextPage( context );
        }
      ),
    ];
  }
}
