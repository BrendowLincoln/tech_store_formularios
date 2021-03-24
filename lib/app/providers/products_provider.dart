import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/app/data/dummy_data.dart';
import 'package:shop/app/providers/product_provider.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductProvider> _items = DUMMY_PRODUCTS;

  List<ProductProvider> get items => [..._items];

  int get itemsCount => _items.length;

  List<ProductProvider> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(ProductProvider newProduct) {
    Uri url = Uri.parse(
        "https://tech-store-9fbb6-default-rtdb.firebaseio.com/produtos.json");
    http.post(
      url,
      body: json.encode({
        'title' : newProduct.title,
        'description' : newProduct.description,
        'price' : newProduct.price,
        'imageUrl' : newProduct.imageUrl,
        'isFavorite' : newProduct.isFavorite,
      }),
    ).then((response) {

      print(json.decode(response.body));

      _items.add(ProductProvider(
          id: json.decode(response.body)['name'],
          title: newProduct.title,
          price: newProduct.price,
          description: newProduct.description,
          imageUrl: newProduct.imageUrl));
      notifyListeners();
    });

  }

  void updateProduct(ProductProvider product) {
    if (product == null && product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items.removeWhere((product) => product.id == id);
      notifyListeners();
    }
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
