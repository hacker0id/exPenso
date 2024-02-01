// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseTile extends StatelessWidget {
  ExpenseTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.dateTime,
      required this.onTilePressed});
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? onTilePressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // !  Delete Button
            SlidableAction(
              onPressed: onTilePressed,
              label: 'Delete',
              icon: FontAwesomeIcons.trash,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(16),
            ),
          ],
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          tileColor: Colors.white60,
          title: Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
          // titleTextStyle: TextStyle(
          //   color: Colors.black,
          //   fontSize: 18,
          // ),
          // subtitleTextStyle:
          // TextStyle(
          //   color: Colors.black,
          //   fontSize: 12,
          // ),
          subtitle: Text(
            '${dateTime.day} / ${dateTime.month} / ${dateTime.year}',
            style: const TextStyle(
              wordSpacing: -2,
              color: Colors.black87,
              fontSize: 13,
            ),
          ),
          trailing: Text(
            '\$$amount',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
