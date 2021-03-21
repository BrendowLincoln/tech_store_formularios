import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/product_provider.dart';
import 'package:shop/app/providers/products_provider.dart';
import 'package:shop/app/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final ProductProvider product;

  ProductItem({
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: (){
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCTS_FORM,
                  arguments: product
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: Text("Tem certeza?"),
                        content: Text("Quer remover esse produto?"),
                        actions: <Widget> [
                          TextButton(
                            child: Text("Não"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text("Sim"),
                            onPressed: () {
                              Provider.of<ProductsProvider>(context, listen: false).deleteProduct(product.id);
                              Navigator.of(context).pop();

                            },
                          )
                        ]
                    )
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
