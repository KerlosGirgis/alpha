import 'package:alpha/models/address.dart';
import 'package:alpha/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/add_address.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: Consumer<UserProvider>(
        builder: (context, user, child) {
          return Column(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    "Your Address",
                    style: TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Spacer(
                    flex: 7,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: MediaQuery.sizeOf(context).width / 1.05,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: user.user.address !=
                              Address(
                                  street: "",
                                  city: "",
                                  state: "",
                                  postalCode: "",
                                  country: "")
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    user.user.address.street,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${user.user.address.city}, ${user.user.address.state}',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  Text(
                                    '${user.user.address.postalCode}, ${user.user.address.country}',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.grey.shade700,
                                ),
                                iconSize: 40,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (builder) {
                                        return const AddAddress();
                                      });
                                },
                              ),
                            ),
                    ),
                  )
                ],
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          );
        },
      ),
    );
  }
}
