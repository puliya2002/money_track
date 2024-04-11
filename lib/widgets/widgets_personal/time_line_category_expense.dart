import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../category_data/icons_list_expense.dart';


class TimeLineCategoryExpense extends StatefulWidget {
  TimeLineCategoryExpense({super.key, required this.onChanged });
  final ValueChanged<String?> onChanged;


  @override
  State<TimeLineCategoryExpense> createState() => _TimeLineCategoryExpenseState();

}

class _TimeLineCategoryExpenseState extends State<TimeLineCategoryExpense> {

String currentCategory = "";
List<Map<String, dynamic>> categorylist = [];

final scrollCounter = ScrollController();
var appIcons = AppIconsExpense();


var addCat =     {
  "name" : "All",
  "icon" : Icons.all_inbox,
};

@override
void initState() {
  super.initState();
  setState(() {
    categorylist = appIcons.homeExpensesCategories;
    categorylist.insert(0, addCat);
  });



}

// scrollToSelectedMonth(){
//
//   if(selectedMonthIndex != -1){
//     final scrollOffset = (selectedMonthIndex * 100.0) -170;
//     scrollCounter.animateTo(scrollOffset,
//         duration: Duration(milliseconds: 500), curve: Curves.ease);
//
//   }
// }


@override
Widget build(BuildContext context) {

  return Container(
        height: 45,
        child: ListView.builder(
            controller: scrollCounter,
            itemCount: categorylist.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (contex, index) {
              var data = categorylist[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentCategory = data['name'];
                    widget.onChanged(data['name']);

                  });

                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: currentCategory == data['name']
                        ? Colors.red
                        : Theme.of(context).colorScheme.secondary,

                    borderRadius: BorderRadius.all(Radius.circular(80)),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(data['icon'],                               color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer, size: 15,),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          data['name'],
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

  );
}
}

