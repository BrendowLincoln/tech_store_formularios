import 'package:flutter/material.dart';
import 'package:shop/app/providers/product_provider.dart';

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
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).accentColor,
              ),
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}
