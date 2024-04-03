import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../widgets/time_line_category.dart';
import '../widgets/time_line_month.dart';

class StatScreen extends StatelessWidget {
  StatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
        child: Column(
          children: [
            TimeLineMonth(
              onChanged: (String? value) {},
            ),
            TimeLineCategory(
              onChanged: (String? value) {},
            ),
          ],
        )



      ),
    );
  }
}
