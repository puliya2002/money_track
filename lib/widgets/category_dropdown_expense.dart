import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_track/data/icons_list_expense.dart';

class CategoryDropDownExpense extends StatelessWidget {
  CategoryDropDownExpense({super.key, this.cattype, required this.onChanged});
  final String? cattype;
  final ValueChanged<String?> onChanged;

  var appIcons = AppIconsExpense();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: DropdownButton<String>(
        value: cattype,
          isExpanded: true,
          hint: Text("Selcet Category"),
          items: appIcons.homeExpensesCategories
              .map((e) => DropdownMenuItem<String>(
            value: e['name'],
              child: Row(
                children: [
                  Icon(
                    e['icon']
                  ),
                  SizedBox(width: 20),

                  Text(e['name']),
                ],
              )))
              .toList(),
          dropdownColor: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(25),
          onChanged: onChanged),
    );
  }
}
