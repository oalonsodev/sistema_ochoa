import 'package:flutter/material.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Theme.of(context).canvasColor,
      child: Container(
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Buscar'
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
    true;
}
