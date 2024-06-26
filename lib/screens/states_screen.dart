import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../widgets/tab_bar_view.dart';
import '../widgets/time_line_category_expense.dart';
import '../widgets/time_line_category_income.dart';
import '../widgets/time_line_month.dart';

class StatScreen extends StatefulWidget {
  StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  var category = "All";
  var monthYear = "";
  @override

  void initState(){
    super.initState();
    DateTime now = DateTime.now();
    setState(() {
      monthYear = DateFormat('MMM y').format(now);
    });
  }



  Widget build(BuildContext context) {

    // String category = ''; // Default value for category
    // String monthYear = ''; // Default value for monthYear



    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Expanded(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TimeLineMonth(
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    monthYear = value;
                  });

                }
              }
              ),

              TypeTabBar( monthYear: monthYear, ),
            ],
          ),
        ),
      )



    );
  }
}
