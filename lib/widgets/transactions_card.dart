import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_track/widgets/icons_list.dart';

class TransactionsCard extends StatelessWidget {
  TransactionsCard({super.key});

  var appIcons = AppIcons();

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: ListView.builder(

        itemCount: 20,
        itemBuilder: (context, int i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Container(
              width: 30,
              height: 75,
              decoration: BoxDecoration(
                color: Theme.of(co ntext).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 16,
                      color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),

                      offset: Offset(2, 4))
                ],

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 47,
                              height: 47,

                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            FaIcon(appIcons.getExpenseCategoryIcons('Grocery'), color: Theme.of(context).colorScheme.onBackground, size: 17,),

                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.9),

                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                            Text(
                              'Date',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ],

                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [

                            Text(
                              'LKR 1500',
                              style: TextStyle(
                                  // color: Theme.of(context).colorScheme.onBackground.withOpacity(0.9),
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),

                            Text(
                              'Date',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ],


                        ),

                      ],

                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
