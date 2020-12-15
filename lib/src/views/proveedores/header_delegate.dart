import 'package:flutter/material.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate {
	@override
	Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Buscar',
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  @override
  //* Este número debe ser menor o igual a la altura del widget dibujado en el build
  double get maxExtent => 91.0;

  @override
  //* Este número debe ser menor o igual a la altura del widget dibujado en el build
  double get minExtent => 91.0;

	@override
	bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
		true;
}
