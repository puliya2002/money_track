import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_track/components/my_dawer.dart';
import 'package:money_track/pages/states_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import '../widgets/add_transaction_form.dart';
import 'main_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  //last added change
  _dialogBuilder(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: AddTransactionForm(),
      );
    });
  }


  final user = FirebaseAuth.instance.currentUser!;

  var wigetList = [
    MainScreen(userID: 'user',),
    StatScreen(),
  ];

  int index = 0;
  late Color selectedItem = Theme.of(context).colorScheme.secondary;
  late Color unselectedItem = Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            elevation: 0,

            title: Image.asset("assets/Logo.png", height: 45,),
            centerTitle: true,

          ),
        ),

        drawer: MyDrawer(),


        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(50),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary,
                ],
                transform: const GradientRotation(pi/2),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: BottomNavigationBar(


                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                  print(value);
                },
                backgroundColor: Colors.transparent,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,

                items: [


                  BottomNavigationBarItem(
                    icon: Container(
                      alignment: AlignmentDirectional.centerEnd,

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(

                          Icons.home_filled,
                          size: 30,
                          color: index == 0 ? selectedItem : unselectedItem,
                        ),
                      ),
                    ),
                    label: 'Home',
                  ),

                  BottomNavigationBarItem(

                    icon: Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.bar_chart,
                          color: index == 1 ? selectedItem : unselectedItem,
                          size: 30,

                        ),
                      ),
                    ),
                    label: 'State',

                  ),
                ],

              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.scale(
                scale: 1.8,
                child: FloatingActionButton(


                  mini: false,
                  onPressed: (() {
                    _dialogBuilder(context);
                  }),
                  elevation: 0.0,
                  shape: const CircleBorder(),
                  child: Container(

                    width: 80,
                    height: 80,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primaryContainer,

                      // gradient: LinearGradient(
                      //   colors: [
                      //     Theme.of(context).colorScheme.secondary,
                      //     Theme.of(context).colorScheme.primary,
                      //   ],
                      //   transform: const GradientRotation(pi / 3),
                      // ),
                      boxShadow:  [
                        BoxShadow(
                            blurRadius: 15,
                            color: Theme.of(context).colorScheme.shadow,
                            offset: Offset(5, 10)),
                      ],
                    ),
                    child: const Icon(CupertinoIcons.minus, color: CupertinoColors.destructiveRed,),
                  ),
                ),

              ),
              Transform.scale(
                scale: 1.8,
                child: FloatingActionButton(
                  mini: false,
                  elevation: 0.0,
                  onPressed: () {},
                  shape: const CircleBorder(),
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Theme.of(context).colorScheme.secondary,
                      //     Theme.of(context).colorScheme.primary,
                      //   ],
                      //   transform: const GradientRotation(pi / 3),
                      // ),
                      boxShadow:  [
                        BoxShadow(
                            blurRadius: 15,
                            color: Theme.of(context).colorScheme.shadow,
                            offset: Offset(5, 10)),
                      ],
                    ),
                    child: const Icon(CupertinoIcons.add, color: CupertinoColors.activeGreen,),
                  ),
                ),

              ),
            ],
          ),
        ),
        body: index == 0 ? MainScreen(userID: 'user',) : StatScreen());
  }
}
