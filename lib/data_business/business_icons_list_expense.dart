import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BusinessAppIconsExpense {
  final List<Map<String,dynamic>> homeExpensesCategories = [
    {
      "name" : "Operating Expenses",
      "icon" : FontAwesomeIcons.toolbox
    },

    {
      "name" : "Payroll and Benefits",
      "icon" : FontAwesomeIcons.paypal,
    },

    {
      "name" : "Marketing and Advertising",
      "icon" : FontAwesomeIcons.tv,
    },

    {
      "name" : "Depreciation and Amortization",
      "icon" : FontAwesomeIcons.tradeFederation,
    },
    {
      "name" : "Professional Services",
      "icon" : CupertinoIcons.person_badge_plus_fill,
    },

    {
      "name" : "Others",
      "icon" : CupertinoIcons.add_circled_solid,
    },
  ];

  IconData getExpenseCategoryIcons(String categoryName){
    final category = homeExpensesCategories.firstWhere(
            (category) => category['name'] == categoryName,
        orElse: ()=> {'icon' : FontAwesomeIcons.cartShopping});
    return category['icon'];

  }
}