import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_track/widgets/time_line_category_expense.dart';
import 'package:money_track/widgets/time_line_category_income.dart';
import 'package:money_track/widgets/states_transaction_list.dart';

class TypeTabBar extends StatefulWidget {
  const TypeTabBar({Key? key, required this.monthYear}) : super(key: key);

  final String monthYear;

  @override
  State<TypeTabBar> createState() => _TypeTabBarState();
}

class _TypeTabBarState extends State<TypeTabBar> {
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
                  text: "Incomes",
                ),
                Tab(
                  text: "Expenses",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 15,),
                      TimeLineCategoryIncome(
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              categoryIncome = value;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 15,),
                      StatesTransactionList(
                        category: categoryIncome,
                        type: 'Credit',
                        monthYear: widget.monthYear,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 15,),
                      TimeLineCategoryExpense(
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              category = value;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 15,),
                      StatesTransactionList(
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
