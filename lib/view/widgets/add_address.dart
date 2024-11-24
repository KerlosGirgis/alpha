import 'package:alpha/controller/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';
import 'button.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController streetController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController stateController = TextEditingController();
    TextEditingController postalController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return Consumer<UserProvider>(
      builder: (context, user, child) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              scrollable: true,
              backgroundColor: const Color(0xffF8F9FF),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xffd8defb),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.add_location_alt_outlined,
                      color: Color(0xff3D5AFE),
                      size: 20,
                    ),
                  ),
                  const Spacer(
                    flex: 10,
                  ),
                  const Text(
                    "Add Address",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  const Spacer(
                    flex: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  )
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: streetController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        labelText: "Street",
                        labelStyle:
                            const TextStyle(fontSize: 30, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.sizeOf(context).height / 80)),
                  TextField(
                    controller: cityController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        labelText: "City",
                        labelStyle:
                            const TextStyle(fontSize: 30, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.sizeOf(context).height / 80)),
                  TextField(
                    controller: stateController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        labelText: "State",
                        labelStyle:
                            const TextStyle(fontSize: 30, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.sizeOf(context).height / 80)),
                  TextField(
                    controller: postalController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        labelText: "Postal Code",
                        labelStyle:
                            const TextStyle(fontSize: 30, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.sizeOf(context).height / 80)),
                  TextField(
                    controller: countryController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        labelText: "Country",
                        labelStyle:
                            const TextStyle(fontSize: 30, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: 'Cancel',
                      status: false,
                      fontSize: 18,
                      size: 1,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Button(
                      onPressed: () async {
                        if (streetController.text.isEmpty ||
                            cityController.text.isEmpty ||
                            stateController.text.isEmpty ||
                            postalController.text.isEmpty ||
                            countryController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "You Must Fill All Fields!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 19.0);
                          return;
                        }
                        await user.addAddress(
                            userId: await AuthService().getUserToken(),
                            street: streetController.text,
                            city: cityController.text,
                            state: stateController.text,
                            postalCode: postalController.text,
                            country: countryController.text,);
                        Navigator.pop(context);
                      },
                      label: 'Save',
                      status: true,
                      fontSize: 18,
                      size: 1,
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
