import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/models/product.dart';
import 'package:shop/app/providers/products_provider.dart';
import 'package:shop/app/widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final ProductsProvider productsProvider = Provider.of<ProductsProvider>(context);
    final List<Product> products = productsProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tech Store'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => ProductItem(
          product: products[index],
        ),
      ),
    );
  }
}
