import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BusinessPieChartExpence extends StatelessWidget {
  const BusinessPieChartExpence({Key? key, this.userId, this.selectedMonth}) : super(key: key);

  final userId;
  final selectedMonth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("business_transactions")
          .where('monthyear', isEqualTo: selectedMonth)
          .where('type', isEqualTo: "Debit")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No transactions found"),
          );
        }

        // Group transactions by category and calculate total amount for each category
        Map<String, double> categoryTotal = {};
        snapshot.data!.docs.forEach((transaction) {
          String category = transaction['category'];
          double amount = transaction['amount'];
          if (categoryTotal.containsKey(category)) {
            categoryTotal[category] = categoryTotal[category]! + amount;
          } else {
            categoryTotal[category] = amount;
          }
        });

        // Generate a list of unique colors
        List<Color> uniqueColors = [
          Color(0xFFFEDE00),
          Colors.blue,
          Colors.pink,
          Colors.grey,
          Colors.brown,
          Colors.red,
          Colors.purple,
          Colors.orange,
          Colors.lightBlueAccent,
          Colors.cyan,
          Color(0xFF67595E),
          Colors.deepPurple,
          Color(0xFFff69b4),
          Color(0xFF68343B),

        ];
        uniqueColors.shuffle(); // Shuffle the list to randomize colors

        // Create a map to store category-color pairs
        Map<String, Color> categoryColors = {};
        categoryTotal.keys.forEach((category) {
          // Pop a color from the shuffled list for each category
          categoryColors[category] = uniqueColors.removeLast();
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Expence Pie Chart",

              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onBackground,

              ),
            ),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      sections: categoryTotal.keys.map((category) {
                        double value = categoryTotal[category]!;
                        return PieChartSectionData(
                          color: categoryColors[category], // Use color from map
                          value: value,
                          title: '${(value * 100 / categoryTotal.values.reduce((a, b) => a + b)).toStringAsFixed(2)}%', // Display percentage
                          radius: 100,
                          titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 40,
              child: Center(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: categoryTotal.keys.map((category) {
                    return Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: categoryColors[category], // Use color from map
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(category, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),
                        SizedBox(width: 20),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
