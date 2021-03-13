import 'package:flutter/material.dart';
import 'package:shop/app/models/product_model.dart';
import 'package:shop/app/providers/counter_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        ModalRoute.of(context).settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(),
    );
  }
}
