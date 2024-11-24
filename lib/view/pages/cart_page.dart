
import 'package:alpha/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    Provider.of<CartProvider>(context, listen: false).getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [Text("${cart.total}\$",style: const TextStyle(fontSize: 24),),const Padding(padding: EdgeInsets.only(right: 15))],
      ),
      body:  cart.cart.isEmpty
              ? Center(child: Image.asset("assets/pics/empty_cart.png",))
              : Column(
                children:[SizedBox(
                  height: MediaQuery.of(context).size.height-200,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: cart.cart.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          color: Colors.white,
                          child: ListTile(
                            title: Row(
                              children: [
                                Image.network(
                                  fit: BoxFit.cover,
                                  scale: 3,
                                  cart.cart[index].book.image,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width - 220,
                                      child: Text(
                                        cart.cart[index].book.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await cart.decrementBookFromCart(cart.cart[index].book.id);
                                            cart.getCart();
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline_sharp,
                                            size: 18,
                                            color: Colors.black,
                                          )),
                                      Text(cart.cart[index].quantity.toString()),
                                      IconButton(
                                          onPressed: () async{
                                            await cart.addBookToCart(cart.cart[index].book.id);
                                            cart.getCart();
                                          },
                                          icon: const Icon(
                                            Icons.add_circle_outline_sharp,
                                            size: 18,
                                            color: Colors.black,
                                          )),
                                      const Padding(padding: EdgeInsets.only(right: 10)),
                                      Text((double.parse(cart.cart[index].book.price.substring(1))*cart.cart[index].quantity).toString())
                                    ],
                                  )
                                ]),
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () async {
                                  await cart
                                      .removeBookFromCart(cart.cart[index].book.id);
                                  cart.getCart();
                                },
                                icon: const Icon(
                                  Icons.delete_sharp,
                                  color: Colors.red,
                                )),
                          ),
                        );
                      }),
                ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 1,
                              backgroundColor: const Color(0xffEB5757),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                          onPressed: () async {
                          },
                          child: const Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 15)),
                              Row(
                                children: [
                                  Padding(padding: EdgeInsets.only(right: 75)),
                                  Text(
                                    "Checkout",
                                    style:
                                    TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 75)),
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 15)),
                            ],
                          ))
                    ],
                  ),
                ],
              ));
        },

    );
  }
}
