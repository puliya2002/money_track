import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeLineMonth extends StatefulWidget {
  TimeLineMonth({super.key, required this.onChanged});
  final ValueChanged<String?> onChanged;

  @override
  State<TimeLineMonth> createState() => _TimeLineMonthState();

}

class _TimeLineMonthState extends State<TimeLineMonth> {

String currentMonth = "";
List<String> months = [];
final scrollCounter = ScrollController();

@override
void initState() {
  super.initState();
  DateTime now = DateTime.now();
  for (int i = -18; i <= 0; i++) {
    months.add(
        DateFormat('MMM y').format(DateTime(now.year, now.month + i, 1)));
  }
  currentMonth = DateFormat('MMM y').format(now);

  Future.delayed(Duration(seconds: 1),(){
    scrollToSelectedMonth();
  });
}

scrollToSelectedMonth(){
  final selectedMonthIndex = months.indexOf(currentMonth);
  if(selectedMonthIndex != -1){
    final scrollOffset = (selectedMonthIndex * 100.0) -170;
    scrollCounter.animateTo(scrollOffset,
        duration: Duration(milliseconds: 500), curve: Curves.ease);

  }
}

Widget build(BuildContext context) {
  return Container(
        height: 45,
        child: ListView.builder(
            controller: scrollCounter,
            itemCount: months.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (contex, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentMonth = months[index];
                    widget.onChanged(months[index]);

                  });
                  scrollToSelectedMonth();
                },
                child: Container(
                  width: 90,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: currentMonth == months[index]
                        ? Colors.blue
                        : Theme.of(context).colorScheme.secondary,

                    borderRadius: BorderRadius.all(Radius.circular(80)),
                  ),
                  child: Center(
                    child: Text(
                      months[index],
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
            }),

  );
}
}

