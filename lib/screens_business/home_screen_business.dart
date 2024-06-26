import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_track/components/my_dawer.dart';
import 'package:money_track/screens/states_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_track/screens_business/states_screen_business.dart';



import '../widgets/add_transaction_expense_form.dart';
import '../components/my_appbar.dart';
import '../widgets/add_transaction_form_income.dart';
import '../widgets_business/business_add_transaction_expense_form.dart';
import '../widgets_business/business_add_transaction_form_income.dart';
import 'main_screen_business.dart';


class HomeScreenBusiness extends StatefulWidget {
  const HomeScreenBusiness({super.key});

  @override
  State<HomeScreenBusiness> createState() => _HomeScreenBusinessState();
}



class _HomeScreenBusinessState extends State<HomeScreenBusiness> {
  //last added change

  _dialogBuilder(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: BusinessAddTransactionFormExpense(),
      );
    }

    );
  }

  _dialogBuilder2(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: BusinessAddTransactionFormIncome(),
        );
      },
    );
  }


  final user = FirebaseAuth.instance.currentUser!;

  var wigetList = [
    MainScreenBusiness(),
    StatScreenBusiness(),
  ];

  int index = 0;
  late Color selectedItem = Theme.of(context).colorScheme.secondary;
  late Color unselectedItem = Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: MyAppBar(image: 'assets/LogoBusiness5.png', actionSection: true,),),

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
                  onPressed: (() {
                    _dialogBuilder2(context);
                  }),
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
        body: index == 0 ? MainScreenBusiness() : StatScreenBusiness());
  }
}
