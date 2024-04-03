import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_track/widgets/icons_list.dart';

class TimeLineCategory extends StatefulWidget {
  TimeLineCategory({super.key, required this.onChanged});
  final ValueChanged<String?> onChanged;

  @override
  State<TimeLineCategory> createState() => _TimeLineCategoryState();

}

class _TimeLineCategoryState extends State<TimeLineCategory> {

String currentCategory = "";

final scrollCounter = ScrollController();
var appIcons = AppIcons();




@override
void initState() {
  super.initState();


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

Widget build(BuildContext context) {
  return Container(
        height: 45,
        child: ListView.builder(
            controller: scrollCounter,
            itemCount: appIcons.homeExpensesCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (contex, index) {
              var data = appIcons.homeExpensesCategories[index];
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
                        ? Colors.blue
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

