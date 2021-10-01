import 'package:flutter_provider_example/modules/cart/models/cart.dart';
import 'package:flutter_provider_example/modules/catalog/models/catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adding item increase total cost', () {
    final catalog = new CatalogModel();
    final cart = CartModel();
    cart.catalog = catalog;
    final startingPrice = cart.totalPrice;
    cart.add(Item(1, 'Dash'));
    expect(cart.totalPrice, greaterThan(startingPrice));
  });
}

