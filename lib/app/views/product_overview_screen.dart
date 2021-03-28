import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/cart_provider.dart';
import 'package:shop/app/providers/products_provider.dart';
import 'package:shop/app/utils/app_routes.dart';
import 'package:shop/app/widgets/app_drawer.dart';
import 'package:shop/app/widgets/badge.dart';
import 'package:shop/app/widgets/product_grid_widget.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    //carregar os produtos

    Provider.of<ProductsProvider>(context, listen: false).loadProducts().then((value)  {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Tech Store'),
        actions: [
          Consumer<Cart>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.CART
              ),
            ),
            builder: (_, cart, child) => Badge(
              child: child,
              value: cart.itemsCount.toString(),
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValeu) {
              setState(() {
                if (selectedValeu == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              )
            ],
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(),)
          : ProductGridWidget(_showFavoriteOnly),
    );
  }
}
