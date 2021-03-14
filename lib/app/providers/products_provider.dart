import 'package:flutter/material.dart';
import 'package:shop/app/data/dummy_data.dart';
import 'package:shop/app/providers/product_provider.dart';

class ProductsProvider with ChangeNotifier {

  List<ProductProvider> _items = DUMMY_PRODUCTS;

  List<ProductProvider> get items => [ ..._items];

  List<ProductProvider> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(ProductProvider product) {
    _items.add(product);
    notifyListeners();
  }

}

// bool _showFavoriteOnly = false;


// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();
// }
//
// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }