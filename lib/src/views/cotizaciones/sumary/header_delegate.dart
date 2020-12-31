import 'package:flutter/material.dart';

import 'package:sistema_ochoa/src/controllers/quotations/sumary/sumary_controller.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate with QuotationSumaryController{
	@override
	Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
		
		initQuotation(context);
    initStyles(context);

    // TODO: Pendiente
    /// Sustituir los Strings por los valores de los productos.
		return Container(
			padding: EdgeInsets.all(16.0),
			color: Theme.of(context).canvasColor,
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: createQuotationProperties()
			)
		);
	}

	@override
	double get maxExtent => 200.0;

	@override
	double get minExtent => 200.0;

	@override
	bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate)
		=> true;
}