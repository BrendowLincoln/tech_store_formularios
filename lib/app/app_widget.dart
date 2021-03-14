import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/cart_provider.dart';
import 'package:shop/app/providers/products_provider.dart';
import 'package:shop/app/utils/app_routes.dart';
import 'package:shop/app/views/product_detail_screen.dart';
import 'package:shop/app/views/product_overview_screen.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tech Store - Seus gadgets preferidos estão aqui!',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Color.fromRGBO(173, 36, 68, 1),
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailScreen(),
        },
      ),
    );
  }
}
