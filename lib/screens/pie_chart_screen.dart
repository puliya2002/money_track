import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_appbar.dart';


class PieChart extends StatelessWidget {
  const PieChart({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: MyAppBar(),
      ),
      body: Text("sd"),
    );
  }
}
