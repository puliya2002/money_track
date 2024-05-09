import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_track/widgets/pie_chart_income.dart';
import 'dart:math';
import '../components/my_appbar.dart';
import '../model/transaction_card_model.dart';
import '../widgets/pie_chart_expence.dart';
import '../widgets_business/business_pie_chart_expence.dart';
import '../widgets_business/business_pie_chart_income.dart';

class PieChartScreenBusiness extends StatelessWidget {
  PieChartScreenBusiness({super.key});

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final selectedMonth = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: MyAppBar(image: 'assets/LogoBusiness5.png', actionSection: false,),
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.42,


                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 16,
                        color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                        offset: Offset(2, 4))
                  ],
                ),
                child: Expanded(
                  child:
                  Padding(
                    padding: const EdgeInsets.all( 20),
                    child: BusinessPieChartExpence(userId: userId, selectedMonth: selectedMonth, ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Container(
                height: MediaQuery.of(context).size.height * 0.42,
                width: double.infinity,


                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 16,
                        color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                        offset: Offset(2, 4))
                  ],
                ),
                child: Expanded(
                  child:
                  Padding(
                    padding: const EdgeInsets.all( 20),
                    child: BusinessPieChartIncome(userId: userId, selectedMonth: selectedMonth, ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  // Generate a random color for each section of the pie chart
  Color getRandomColor() {
    List<Color> colors = [

      Colors.green,
      Colors.greenAccent,
      Colors.blueGrey,

    ];

    // Generate a random index to select a color from the list
    int randomIndex = Random().nextInt(colors.length);

    // Return the color at the randomly selected index
    return colors[randomIndex];
  }
}
