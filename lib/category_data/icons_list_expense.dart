import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppIconsExpense {
  final List<Map<String,dynamic>> homeExpensesCategories = [
    {
      "name" : "Gass Filling",
      "icon" : FontAwesomeIcons.gasPump,
    },

    {
      "name" : "Car",
      "icon" : FontAwesomeIcons.car,
    },

    {
      "name" : "Grocery",
      "icon" : FontAwesomeIcons.cartShopping,
    },

    {
      "name" : "Dine In",
      "icon" : FontAwesomeIcons.hamburger,
    },
    {
      "name" : "Bill",
      "icon" : FontAwesomeIcons.moneyBill1Wave,
    },

    {
      "name" : "Communication",
      "icon" : FontAwesomeIcons.phone,
    },

    {
      "name" : "Travel",
      "icon" : FontAwesomeIcons.plane,
    },

    {
      "name" : "health",
      "icon" : FontAwesomeIcons.solidHospital,
    },

    {
      "name" : "Entertainment",
      "icon" : FontAwesomeIcons.wineGlass,
    },

    {
      "name" : "House",
      "icon" : FontAwesomeIcons.house,
    },

    {
      "name" : "Gift",
      "icon" : FontAwesomeIcons.gifts,
    },

    {
      "name" : "Loan",
      "icon" : FontAwesomeIcons.moneyBillTransfer,
    },

    {
      "name" : "Cloths",
      "icon" : FontAwesomeIcons.shirt,
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