import 'package:flutter/material.dart';

class HistoryCommentTile extends StatelessWidget {
  final String title;
  final String comment;
  const HistoryCommentTile({super.key, required this.title, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.newspaper, size: 22, color: Colors.grey[800],),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 17),),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.comment, size: 22, color: Colors.grey[800],),
              const SizedBox(width: 10),
              Text(comment, style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),)
            ],
          )
        ],
      ),
    );
  }
}