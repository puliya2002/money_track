import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/business_personal_provider.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key, required this.image, required this.actionSection});
  final String image;
  final bool actionSection;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      title: Image.asset(
        image,
        height: 45,
      ),
      centerTitle: true,
      actions: actionSection
          ? [
              Consumer<SwitchProvider>(
                builder: (context, switchProvider, _) => Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: DropdownButton<String>(
                      dropdownColor: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(20),
                      value:
                          switchProvider.isBusiness ? 'BUSINESS' : 'PERSONAL',
                      items: <String>['BUSINESS', 'PERSONAL']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        switchProvider.toggleSwitch(newValue == 'BUSINESS');
                      },
                    ),
                  ),
                ),
              )
            ]
          : [],
    );
  }
}
