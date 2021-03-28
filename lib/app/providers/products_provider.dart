import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/app/providers/product_provider.dart';

class ProductsProvider with ChangeNotifier {

  final Uri _url = Uri.parse(
      "https://tech-store-9fbb6-default-rtdb.firebaseio.com/produtos.json");

  List<ProductProvider> _items = [];

  List<ProductProvider> get items => [..._items];

  int get itemsCount => _items.length;

  List<ProductProvider> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }


  Future<void> loadProducts() async {
    final response = await http.get(_url);

    Map<String, dynamic> data = json.decode(response.body);
    _items.clear();
    if(data != null) {
      data.forEach((productId, productData) {
        _items.add(ProductProvider(
            id: productId,
            title: productData["title"],
            description: productData["description"],
            price: productData["price"],
            imageUrl: productData["imageUrl"],
            isFavorite: productData['isFavorite'])

        );
      });

      notifyListeners();
      return Future.value();
    }
    }


  Future<void> addProduct(ProductProvider newProduct) async {


    final response = await http.post(
      _url,
      body: json.encode({
        'title' : newProduct.title,
        'description' : newProduct.description,
        'price' : newProduct.price,
        'imageUrl' : newProduct.imageUrl,
        'isFavorite' : newProduct.isFavorite,
      }),
    );

    _items.add(ProductProvider(
        id: json.decode(response.body)['name'],
        title: newProduct.title,
        price: newProduct.price,
        description: newProduct.description,
        imageUrl: newProduct.imageUrl));
    notifyListeners();
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
