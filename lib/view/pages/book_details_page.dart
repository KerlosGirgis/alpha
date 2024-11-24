import 'package:alpha/provider/favourites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/book.dart';
import '../../provider/cart_provider.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key, required this.bookDetails});

  @override
  State<BookDetails> createState() => _BookDetailsState();

  final Book bookDetails;
}

class _BookDetailsState extends State<BookDetails> {
  @override
  void initState(){
     Provider.of<FavouritesProvider>(context, listen: false)
        .getSaved();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              size: 42,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        actions: [
          Consumer<FavouritesProvider>(
            builder: (context, fav, child) {
              return IconButton(
                  onPressed: () async {
                    if(fav.checkIfSaved(widget.bookDetails.id)){
                      await fav.removeBookFromSaved(widget.bookDetails.id);
                      await fav.getSaved();
                    }
                    else{
                      await fav.saveBookToUser(widget.bookDetails.id);
                      await fav.getSaved();
                    }
                  },
                  icon: fav.checkIfSaved(widget.bookDetails.id)
                      ? const Icon(
                          Icons.favorite_sharp,
                          size: 42,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border_sharp,
                          size: 42,
                          color: Colors.black,
                        ));
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                fit: BoxFit.cover,
                widget.bookDetails.image,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  widget.bookDetails.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.bookDetails.price.toString(),
                style: const TextStyle(fontSize: 18, color: Color(0xffEB5757)),
              )
            ],
          ),
          const Spacer(
            flex: 2,
          ),
          const Row(
            children: [
              Padding(padding: EdgeInsets.only(right: 30)),
              Text(
                "Overview",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width - 90,
                  child: Text(
                    widget.bookDetails.subtitle,
                    style: const TextStyle(fontSize: 20),
                  ))
            ],
          ),
          const Spacer(
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 1,
                      backgroundColor: const Color(0xffEB5757),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  onPressed: () async {
                    await Provider.of<CartProvider>(context, listen: false)
                        .addBookToCart(widget.bookDetails.id);
                  },
                  child: const Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 15)),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(right: 75)),
                          Text(
                            "Add To Cart",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Padding(padding: EdgeInsets.only(right: 75)),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 15)),
                    ],
                  ))
            ],
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
