import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/models/product_model.dart';
import 'package:shop/app/providers/products_provider.dart';
import 'package:shop/app/widgets/product_item.dart';

class ProductGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    final List<ProductModel> products = productsProvider.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index], // Utilizando o construtor nomeado ChangeNotifierProvider.value para valores já anteriormente criados
          child: ProductItem()
      ),
    );
  }
}
