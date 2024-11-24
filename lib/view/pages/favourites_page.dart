
import 'package:alpha/provider/favourites_provider.dart';
import 'package:alpha/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_details_page.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({
    super.key,
  });

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<FavouritesProvider>(
        builder: (context, fav, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text(
                  "Favourites",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
              ),
              body:  fav.saved.isEmpty
                  ? Center(child: Image.asset("assets/pics/empty_favourites.png",))
                  : GridView.builder(
                  itemCount: fav.saved.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                      MediaQuery.of(context).orientation ==
                          Orientation.portrait
                          ? 2
                          : 4,
                      childAspectRatio: 0.6),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Column(children: [
                        Image.network(
                          fav.saved[index].image,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress
                                    .expectedTotalBytes !=
                                    null
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    loadingProgress
                                        .expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                        Text(
                          fav.saved[index].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(
                          fav.saved[index].price.toString(),
                          style: const TextStyle(
                              color: Color(0xffEB5757)),
                        )
                      ]),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation,
                                secondaryAnimation) =>
                                BookDetails(
                                    bookDetails: fav.saved[index]),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.ease;
                              var tween = Tween(
                                  begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation =
                              animation.drive(tween);
                              return SlideTransition(
                                  position: offsetAnimation,
                                  child: child);
                            },
                          ),
                        );
                      },
                    );
                  }));
        },

      );
  }
}
