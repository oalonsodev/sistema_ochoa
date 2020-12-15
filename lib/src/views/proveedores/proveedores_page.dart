import 'package:flutter/material.dart';
import 'package:sistema_ochoa/src/views/proveedores/header_delegate.dart';

class ProveedoresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _createHeader(),
        _createBody(context)
      ],
    );
  }

  SliverPersistentHeader _createHeader() {
    // TODO: Crear FTBuilder que muestre la lista de resultados,
		// todo: y poner este widget como initialData.
    return SliverPersistentHeader(
      delegate: HeaderDelegate(),
      pinned: true
    );
  }

  SliverFillRemaining _createBody(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Icon(Icons.work_off, size: 200.0, color: Colors.grey),
					Text(
						'No hay proveedores para mostrar',
						style: Theme.of(context).textTheme.subtitle2,
					)
				],
			)
    );
  }

}