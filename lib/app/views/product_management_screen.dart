import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/products_provider.dart';
import 'package:shop/app/widgets/app_drawer.dart';
import 'package:shop/app/widgets/product_item.dart';

class ProductManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.items;


    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar de Produtos")
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.itemsCount,
          itemBuilder: (context, index) => Column(
            children: [
              ProductItem(product: products[index],),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
