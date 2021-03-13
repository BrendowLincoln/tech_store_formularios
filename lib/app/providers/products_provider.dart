import 'package:flutter/material.dart';
import 'package:shop/app/data/dummy_data.dart';
import 'package:shop/app/models/product_model.dart';

class ProductsProvider with ChangeNotifier {

  List<ProductModel> _items = DUMMY_PRODUCTS;


  List<ProductModel> get items =>[ ..._items ];

  void addProduct(ProductModel product) {
    _items.add(product);
    notifyListeners();
  }

}