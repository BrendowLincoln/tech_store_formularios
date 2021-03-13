import 'package:flutter/material.dart';
import 'package:shop/app/models/product.dart';
import 'package:shop/app/providers/counter_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context).settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(CounterProvider.of(context).state.value.toString()),
            SizedBox(height: 20,),
            ElevatedButton(
              child: Text("+"),
              onPressed: () {
                setState(() {
                  CounterProvider.of(context).state.increment();
                  print(CounterProvider.of(context).state.value);
                });
              },
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              child: Text("-"),
              onPressed: () {
                setState(() {
                  if(CounterProvider.of(context).state.value > 0)
                  CounterProvider.of(context).state.decremente();
                  print(CounterProvider.of(context).state.value);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
