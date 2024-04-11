import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'business_states_transaction_list.dart';
import 'business_time_line_category_expense.dart';
import 'business_time_line_category_income.dart';

class BusinessTypeTabBar extends StatefulWidget {
  const BusinessTypeTabBar({Key? key, required this.monthYear}) : super(key: key);

  final String monthYear;

  @override
  State<BusinessTypeTabBar> createState() => _BusinessTypeTabBarState();
}

class _BusinessTypeTabBarState extends State<BusinessTypeTabBar> {
  late String category;
  late String categoryIncome;

  @override
  void initState() {
    super.initState();
    category = "All";
    categoryIncome = "All";
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  text: "Credit",
                ),
                Tab(
                  text: "Debit",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 15,),
                      BusinessTimeLineCategoryIncome(
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              categoryIncome = value;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 15,),
                      BusinessStatesTransactionList(
                        category: categoryIncome,
                        type: 'Credit',
                        monthYear: widget.monthYear,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 15,),
                      BusinessTimeLineCategoryExpense(
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              category = value;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 15,),
                      BusinessStatesTransactionList(
                        category: category,
                        type: 'Debit',
                        monthYear: widget.monthYear,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
