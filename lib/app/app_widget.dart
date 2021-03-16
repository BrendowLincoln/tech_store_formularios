import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/providers/cart_provider.dart';
import 'package:shop/app/providers/orders_provider.dart';
import 'package:shop/app/providers/products_provider.dart';
import 'package:shop/app/utils/app_routes.dart';
import 'package:shop/app/views/cart_screen.dart';
import 'package:shop/app/views/orders_screen.dart';
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
        ),
        ChangeNotifierProvider(
            create: (context) => Orders(),
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
        initialRoute: AppRoutes.HOME,
        routes: {
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailScreen(),
          AppRoutes.CART: (context) => CartScreen(),
          AppRoutes.ORDERS: (context) => OrdersScreen(),
          AppRoutes.HOME: (context) => ProductOverviewScreen()
        },
      ),
    );
  }
}
