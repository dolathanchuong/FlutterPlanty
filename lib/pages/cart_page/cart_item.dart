import 'package:flutter/material.dart';
import '../../classes/plant.dart';

class CartItem extends StatelessWidget {
  final Plant plant;
  const CartItem(this.plant, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        elevation: 30.0,
        shadowColor: Colors.black54,
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: ListTile(
            leading: Image.asset('res/${plant.plantImg}'),
            title: Text(plant.plantName,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0)),
            subtitle: Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                child: Text(
                    plant.price - plant.price.truncate() > 0
                        ? '\$${plant.price.toStringAsFixed(2)}'
                        : '\$${plant.price.truncate()}',
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete, color: Colors.black26),
            ),
          ),
        ),
      ),
    );
  }
}
