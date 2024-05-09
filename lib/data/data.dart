import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, dynamic>> transactionsData = [
  {
    'icon': const FaIcon(FontAwesomeIcons.plane, color: Colors.white, size: 20,),
    'name': 'Travel' ,
    'totalAmount': '- LKR 500',
    'date': 'Today',
    'color' : Colors.yellow
  },

  {
    'icon': const FaIcon(FontAwesomeIcons.burger, color: Colors.white, size: 20,),
    'name': 'Food' ,
    'totalAmount': '- LKR 45',
    'date': 'Yesterday',
    'color' : Colors.green
  },

  {
    'icon': const FaIcon(FontAwesomeIcons.hospital, color: Colors.white, size: 20,),
    'name': 'Health' ,
    'totalAmount': '- LKR 255',
    'date': 'Today',
    'color' : Colors.red
  },

  {
    'icon': const FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white, size: 20,),
    'name': 'Shopping' ,
    'totalAmount': '- LKR 1000',
    'date': 'Today',
    'color' : Colors.deepPurple
  },


  {
    'icon': const FaIcon(FontAwesomeIcons.pizzaSlice, color: Colors.white, size: 20,),
    'name': 'Dine-in' ,
    'totalAmount': '- LKR 4500',
    'date': 'Yesterday',
    'color' : Colors.blue,
  },

  {
    'icon': const FaIcon(FontAwesomeIcons.bus, color: Colors.white, size: 20,),
    'name': 'Transport' ,
    'totalAmount': '- LKR 1255',
    'date': 'Today',
    'color' : Colors.purpleAccent,
  },

  {
    'icon': const FaIcon(FontAwesomeIcons.car, color: Colors.white, size: 20,),
    'name': 'Car' ,
    'totalAmount': '- LKR 150000',
    'date': 'Today',
    'color' : Colors.brown,
  }


];