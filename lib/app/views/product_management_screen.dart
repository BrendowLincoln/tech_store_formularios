import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/products_provider.dart';
import 'package:shop/app/utils/app_routes.dart';
import 'package:shop/app/widgets/app_drawer.dart';
import 'package:shop/app/widgets/product_item.dart';

class ProductManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.items;

    Future<void> _refreshProducts(BuildContext context) async {
      await Provider.of<ProductsProvider>(context, listen: false).loadProducts();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar de Produtos"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCTS_FORM
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.itemsCount,
            itemBuilder: (context, index) => Column(
              children: [
                ProductItem(
                  product: products[index],
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
