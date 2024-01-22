import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:eautosalon_mobile/widgets/user_history_comment.dart';
import 'package:flutter/material.dart';

class HistoryComments extends StatefulWidget {
  const HistoryComments({super.key});

  @override
  State<HistoryComments> createState() => _HistoryCommentsState();
}

class _HistoryCommentsState extends State<HistoryComments> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Vaši komentari',
       body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: const [
            HistoryCommentTile(comment: 'Odličan članak', title: 'Lorem ipsum',),
            HistoryCommentTile(comment: 'Odličan članak', title: 'Lorem ipsum',),
            HistoryCommentTile(comment: 'Odličan članak', title: 'Lorem ipsum',),
            HistoryCommentTile(comment: 'Odličan članak', title: 'Lorem ipsum',)
          ],
        ),
       )
    );
  }
}