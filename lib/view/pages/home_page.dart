import 'package:alpha/provider/books_provider.dart';
import 'package:alpha/provider/user_provider.dart';
import 'package:alpha/view/pages/book_details_page.dart';
import 'package:alpha/view/pages/cart_page.dart';
import 'package:alpha/view/pages/favourites_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getUserData();
    super.initState();
  }

  int? selectedItem;
  List<String> categories = [
    "Novels",
    "Self-Help",
    "Science",
    "Romance",
    "Children"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Image.asset(
            "assets/logo/logo3.png",
            scale: 3,
          ),
          title: const Text(
            "Alpha",
            style: TextStyle(
                fontSize: 28,
                color: Color(
                  0xffEB5757,
                ),
                fontWeight: FontWeight.bold),
          ),
          titleSpacing: 0,
          actions: [
            Row(
              children: [
                /*IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation,
                              secondaryAnimation) =>
                          const FavouritesPage(),
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
                    icon: const Icon(
                      Icons.favorite_outline_rounded,
                      color: Colors.black,
                      size: 32,
                    )),*/
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation,
                              secondaryAnimation) =>
                              const CartPage(),
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
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                      size: 32,
                    )),
                const Padding(padding: EdgeInsets.only(right: 10))
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(right: 15)),
                    Consumer<UserProvider>(
                      builder: (context, user, child) {
                        return Text(
                          "Hello, ${user.user.name} ",
                          style: const TextStyle(
                              fontSize: 32,
                              color: Color(
                                0xffEB5757,
                              ),
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    const Icon(
                      Icons.waving_hand_sharp,
                      size: 15,
                      color: Colors.amberAccent,
                    )
                  ],
                ),
                const Row(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 20)),
                    Text(
                      "What do you want to read today?",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      height: 70,
                      child: TextFormField(
                        style: const TextStyle(fontSize: 22),
                        maxLines: 1,
                        decoration: InputDecoration(
                            focusColor: Colors.grey,
                            hintStyle: const TextStyle(
                                fontSize: 22, color: Colors.grey),
                            hintText: "Search",
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            suffix: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.manage_search,
                                  color: Color(
                                    0xffEB5757,
                                  ),
                                )),
                            prefixIcon: const Icon(
                              Icons.search_sharp,
                              size: 32,
                              color: Colors.grey,
                            )),
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 60,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedItem = index;
                                });
                              },
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: selectedItem == index
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ));
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 580,
                  child:
                      Consumer<BooksProvider>(builder: (context, books, child) {
                    return books.books.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            itemCount: books.books.length,
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
                                    books.books[index].image,
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
                                    books.books[index].title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    books.books[index].price.toString(),
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
                                              bookDetails: books.books[index]),
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
                            });
                  }),
                )
              ],
            )));
  }
}
