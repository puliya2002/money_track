import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:money_track/pages/main_screen.dart';
import 'package:money_track/pages/profile.dart';
import 'package:provider/provider.dart';

import '../provider/currency_provider.dart';
import '../provider/theme_provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                      ),
                    ),
                    Icon(
                      CupertinoIcons.person_fill,
                      color: Colors.black,
                      size: 18,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome!",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      user.email!,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(

                    children: [
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text("Home"),
                        onTap: (){
                          Navigator.pop(context); // Close the drawer


                        },
                      ),

                      ListTile(
                        leading: Icon(Icons.format_paint,),
                        title: Text("Theme"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Select Theme"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: const Text("Light Theme"),
                                      onTap: () {
                                        Provider.of<ThemeProvider>(context, listen: false)
                                            .setTheme(ThemeType.Light);

                                      },
                                      selected: Provider.of<ThemeProvider>(context).getCurrentTheme() == ThemeType.Light,
                                    ),
                                    ListTile(
                                      title: const Text("Dark Theme"),
                                      onTap: () {
                                        Provider.of<ThemeProvider>(context, listen: false)
                                            .setTheme(ThemeType.Dark);
                                      },
                                      selected: Provider.of<ThemeProvider>(context).getCurrentTheme() == ThemeType.Dark,
                                    ),

                                    ListTile(
                                      title: const Text("System Default"),
                                      onTap: () {
                                        Provider.of<ThemeProvider>(context, listen: false)
                                            .setTheme(ThemeType.System);
                                      },
                                      selected: Provider.of<ThemeProvider>(context).getCurrentTheme() == ThemeType.System,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),

                      ListTile(
                        leading: Icon(Icons.monetization_on,),
                        title: Text("Currency"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Select Currency"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: const Text("LKR"),
                                      onTap: () {
                                        Provider.of<CurrencyProvider>(context, listen: false).setCurrency("LKR ");
                                        Navigator.pop(context);
                                      },
                                      selected: Provider.of<CurrencyProvider>(context).selectedCurrency == "LKR ",
                                    ),
                                    ListTile(
                                      title: const Text("USD"),
                                      onTap: () {
                                        Provider.of<CurrencyProvider>(context, listen: false).setCurrency("USD ");
                                        Navigator.pop(context);
                                      },
                                      selected: Provider.of<CurrencyProvider>(context).selectedCurrency == "USD ",
                                    ),

                                    ListTile(
                                      title: const Text("GBP"),
                                      onTap: () {
                                        Provider.of<CurrencyProvider>(context, listen: false).setCurrency("GBP ");
                                        Navigator.pop(context);
                                      },
                                      selected: Provider.of<CurrencyProvider>(context).selectedCurrency == "GBP ",
                                    ),


                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),

                      ListTile(
                        leading: Icon(Icons.face),
                        title: Text("Profile"),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );


                        },
                      ),

                    ],
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red,),
                    title: Text("Log Out", style: TextStyle(color: Colors.red),),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      },

                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
