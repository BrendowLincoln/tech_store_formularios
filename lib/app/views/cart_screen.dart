import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(25),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 10),
                  Chip(
                    label: Text(
                      'R\$ ${cart.totalAmount}',
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'CHECKOUT',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
