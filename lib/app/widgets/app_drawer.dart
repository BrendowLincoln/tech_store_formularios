import 'package:flutter/material.dart';
import 'package:shop/app/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
              title: Text(
                  'Bem vindo Usuário!'
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.HOME
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedido'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  AppRoutes.ORDERS
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                  AppRoutes.PRODUCTS_MANAGEMENT
              );
            },
          ),
          Divider(),

        ],
      ),
    );
  }
}
