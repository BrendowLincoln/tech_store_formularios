import 'package:flutter/material.dart';
import 'package:shop/app/views/product_overview_screen.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tech Store - Seus gadgets preferidos estão aqui!',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: ProductOverviewScreen(),
    );
  }
}
