import 'package:flutter/material.dart';
import 'package:shop/app/widgets/product_grid_widget.dart';

class ProductOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tech Store'),
        centerTitle: true,
      ),
      body: ProductGridWidget(),
    );
  }
}
