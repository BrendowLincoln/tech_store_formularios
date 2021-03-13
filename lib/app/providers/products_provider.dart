import 'package:flutter/material.dart';
import 'package:shop/app/data/dummy_data.dart';
import 'package:shop/app/models/product.dart';

class ProductsProvider with ChangeNotifier {

  List<Product> _items = DUMMY_PRODUCTS;


  List<Product> get items =>[ ..._items ];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

}