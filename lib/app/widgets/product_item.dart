import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/models/product_model.dart';
import 'package:shop/app/utils/app_routes.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final ProductModel product = Provider.of<ProductModel>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            return Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.grey.withOpacity(0.9),
          leading: IconButton(
            icon: Icon(
              product.isFavorite
                ? Icons.favorite
              : Icons.favorite_border_outlined,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => product.toggleFavorite(),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
