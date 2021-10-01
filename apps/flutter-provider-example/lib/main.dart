import 'package:flutter/material.dart';
import 'package:flutter_provider_example/config/themes/theme.dart';
import 'package:flutter_provider_example/modules/cart/models/cart.dart';
import 'package:flutter_provider_example/modules/cart/screens/cart.dart';
import 'package:flutter_provider_example/modules/catalog/models/catalog.dart';
import 'package:flutter_provider_example/modules/catalog/screens/catalog.dart';
import 'package:flutter_provider_example/modules/login/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) {
              throw ArgumentError.notNull('cart');
            }

            cart.catalog = catalog;

            return cart;
          }
        ),
      ],
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart()
        },
      ),
    );
  }
}
