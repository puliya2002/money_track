import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIcons {
  final List<Map<String,dynamic>> homeExpensesCategories = [
    {
      "name" : "Gass Filling",
      "icon" : FontAwesomeIcons.gasPump,
    },

    {
      "name" : "Grocery",
      "icon" : FontAwesomeIcons.cartShopping,
    },

    {
      "name" : "Food",
      "icon" : FontAwesomeIcons.burger,
    },
    {
      "name" : "Others",
      "icon" : FontAwesomeIcons.cartShopping,
    },
  ];

  IconData getExpenseCategoryIcons(String categoryName){
    final category = homeExpensesCategories.firstWhere(
            (category) => category['name'] == categoryName,
        orElse: ()=> {'icon' : FontAwesomeIcons.cartShopping});
    return category['icon'];

  }
}