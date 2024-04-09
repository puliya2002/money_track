import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/icons_list.dart';
import '../provider/currency_provider.dart';

class TransactionModel extends StatelessWidget {
  TransactionModel({
    super.key,
    required this.data,
  });
  final dynamic data;

  var appIcons = AppIcons();

  @override
  Widget build(BuildContext context) {
    String currency = Provider.of<CurrencyProvider>(context).selectedCurrency;

    var addedDate = (data['timestamp'] as Timestamp).toDate();
    String formatDateTime(DateTime dateTime) {
      return DateFormat.yMMMMd().add_jm().format(dateTime);
    }
    // String formatedDate = DateFormat('d MMM hh:mm a').format(date);

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Container(
        width: 30,
        height: 75,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                blurRadius: 16,
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                offset: Offset(2, 4))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 47,
                        height: 47,
                        decoration: BoxDecoration(
                          color: data['type'] == 'Credit'
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      FaIcon(
                        appIcons.getExpenseCategoryIcons("${data['category']}"),
                        color: data['type'] == 'Credit'
                        ? Colors.green
                        : Colors.red,
                        size: 17,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data['title']}",
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.9),
                            fontWeight: FontWeight.w800,
                            fontSize: 17),
                      ),
                      Text(
                        formatDateTime(addedDate),
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${data['type'] == 'Credit' ? '+' : '-'} $currency ${data['amount']}",
                        style: TextStyle(
                            // color: Theme.of(context).colorScheme.onBackground.withOpacity(0.9),
                            color: data['type'] == 'Credit'
                                ? Colors.green
                                : Colors.red,

                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                      Text(
                        "$currency ${data['remainingAmount']}",
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.6),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
