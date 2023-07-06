import 'package:flutter/material.dart';
import '../../classes/cart.dart';
import '../../classes/plants_list.dart';
import 'cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    if (Cart.cartItems.isNotEmpty) {
      return Material(
        borderRadius: BorderRadius.circular(8.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: const Text('Shopping cart',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 26.0)),
            actions: <Widget>[
              Center(
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.black45),
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: ListView.builder(
            itemCount: Cart.cartItems.length,
            itemBuilder: (_, int pos) =>
                CartItem(plantsList[Cart.cartItems[pos]]),
          ),
          bottomNavigationBar: Hero(
            tag: 'Buy button',
            child: MaterialButton(
              onPressed: () {},
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                    'Buy Now (\$${calculateFinalPrice().toStringAsFixed(2)})',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ),
      );
    } else // Show an empty state
    {
      return Material(
        borderRadius: BorderRadius.circular(8.0),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              title: const Text('Shopping cart',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 26.0)),
              actions: <Widget>[
                Center(
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.black45),
                  ),
                )
              ],
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.remove_shopping_cart,
                      color: Colors.black26, size: 96.0),
                  const Padding(padding: EdgeInsets.only(bottom: 48.0)),
                  const Text('Your cart is empty!',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 28.0)),
                  const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: const Text(
                        'Looks like you haven\'t added any plants to your cart yet.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0)),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 96.0)),
                  Material(
                    elevation: 16.0,
                    shadowColor: const Color(0x7000E676),
                    color: Colors.white,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 64.0, vertical: 16.0),
                        child: Text('Go back',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  )
                ],
              ),
            )),
      );
    }
  }

  double calculateFinalPrice() {
    double cost = 0.0;
    for (int plantPos in Cart.cartItems) {
      cost += plantsList[plantPos].price;
    }

    return cost;
  }
}
