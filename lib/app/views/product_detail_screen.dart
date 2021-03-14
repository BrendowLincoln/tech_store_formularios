import 'package:flutter/material.dart';
import 'package:shop/app/providers/product_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductProvider product =
        ModalRoute.of(context).settings.arguments as ProductProvider;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(),
    );
  }
}
