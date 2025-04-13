import 'package:flutter/material.dart';
import 'package:leetcode_tracker/models/countmodel.dart';

class Countdisplay extends StatelessWidget {
  Countdisplay({super.key, required this.countmodel, required this.index});

  final Countmodel countmodel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        tileColor: Color.fromRGBO(37, 1, 84, 1),

        leading: Text(
          '${index + 1}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        title: Text(
          countmodel.Student_name ?? 'No Name',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID: ${countmodel.Leetcode_id ?? 'N/A'}",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
            Text(
              "Ratings: ${countmodel.ratings?.toStringAsFixed(0) ?? 'N/A'}",
              style: const TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
        trailing: Text(
          "Solved\n${countmodel.count ?? 0}",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
