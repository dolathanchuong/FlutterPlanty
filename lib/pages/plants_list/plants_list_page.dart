import 'package:flutter/material.dart';

import 'plant_preview.dart';
import '../cart_page/cart_page.dart';
import '../../classes/plants_list.dart';
import '../../classes/cart.dart';

class PlantsListPage extends StatefulWidget {
  const PlantsListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PlantsListPageState createState() => _PlantsListPageState();
}

class _PlantsListPageState extends State<PlantsListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Color?> boughtBgColorAnimation =
      const AlwaysStoppedAnimation<Color>(Colors.blue);
  late Animation<Color?> boughtIconColorAnimation =
      const AlwaysStoppedAnimation<Color>(Colors.green);

  bool showBoughtOverlay = false;
  int actualPlant = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animationController.addListener(() => setState(() {}));

    boughtBgColorAnimation =
        ColorTween(begin: Colors.transparent, end: Colors.greenAccent).animate(
            CurvedAnimation(
                parent: animationController, curve: Curves.decelerate));

    boughtIconColorAnimation =
        ColorTween(begin: Colors.transparent, end: Colors.white).animate(
            CurvedAnimation(
                parent: animationController, curve: Curves.decelerate));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.0,
          leading: IconButton(
            onPressed: () => showAboutDialog(
                context: context,
                applicationIcon: SizedBox(
                    width: 60.0, child: Image.asset('res/app_icon.png')),
                applicationLegalese:
                    'A plant shop e-commerce app concept.\n\nMade by Ivascu Adrian (Skuu labs).'),
            icon: const Icon(Icons.menu, color: Colors.black),
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Plantly',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w700)),
              Text('.',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 36.0,
                      fontWeight: FontWeight.w700))
            ],
          ),
          actions: <Widget>[
            Center(
              child: IconButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CartPage())),
                  icon: Stack(
                    children: <Widget>[
                      const Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.shopping_basket, color: Colors.black),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 6.0,
                          backgroundColor: Colors.green,
                          child: Text(Cart.cartItems.length.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 8.0)),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            /// Plants list, buttons and buy button
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                /// Plants PageView
                Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: plantsList.length,
                    itemBuilder: (_, int pos) => PlantPreview(plantsList[pos]),
                    onPageChanged: (int newPlantPos) =>
                        actualPlant = newPlantPos,
                  ),
                ),

                /// Like and share buttons
                Container(
                  margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.favorite_border,
                                    color: Colors.green),
                                Padding(padding: EdgeInsets.only(right: 8.0)),
                                Text('426',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Share',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w700)),
                                Padding(padding: EdgeInsets.only(right: 8.0)),
                                Icon(Icons.share, color: Colors.green),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Buy button
                Hero(
                  tag: 'Buy button',
                  child: MaterialButton(
                    onPressed: () => buyPlant(),
                    color: Colors.green,
                    child: const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text('Add to cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),

            /// When a plant is bought
            showBoughtOverlay
                ? SizedBox.expand(
                    child: Container(
                      color: boughtBgColorAnimation.value,
                      child: Center(
                          child: Icon(Icons.done,
                              size: 128.0,
                              color: boughtIconColorAnimation.value)),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  void buyPlant() {
    setState(() {
      showBoughtOverlay = true;
      Cart.cartItems.add(actualPlant);

      animationController.forward().then((_) => animationController
          .reverse()
          .then((_) => setState(() => showBoughtOverlay = false)));
    });
  }
}
