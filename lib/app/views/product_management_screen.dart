import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/products_provider.dart';
import 'package:shop/app/widgets/app_drawer.dart';

class ProductManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsProvider products = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar de Produtos")
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (context, index) => Text("Teste ${index + 1}"),
        ),
      ),
    );
  }
}
