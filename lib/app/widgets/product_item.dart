import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/cart_provider.dart';
import 'package:shop/app/providers/product_provider.dart';
import 'package:shop/app/utils/app_routes.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final ProductProvider product = Provider.of<ProductProvider>(context, listen: false);

    final Cart cart = Provider.of<Cart>(context, listen: false);


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
          leading: Consumer<ProductProvider>(
            builder: (context, product, _) => IconButton(
              icon: Icon(
                product.isFavorite
                  ? Icons.favorite
                : Icons.favorite_border_outlined,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => product.toggleFavorite(),
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.add_shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Produto adicionado com sucesso!"),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                      label: "DESFAZER",
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                  ),
                )
              );
              cart.addItem(product);
            },
          ),
        ),
      ),
    );
  }
}
