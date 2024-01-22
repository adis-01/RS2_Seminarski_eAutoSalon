import 'package:eautosalon_mobile/widgets/user_history_review.dart';
import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';
class HistoryReviews extends StatefulWidget {
  const HistoryReviews({super.key});

  @override
  State<HistoryReviews> createState() => _HistoryReviewsState();
}

class _HistoryReviewsState extends State<HistoryReviews> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Vaše recenzije',
       body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: const[
            HistoryReviewTile(ocjena: 5, comment: "Sve pohvale za autosalon",),
            HistoryReviewTile(ocjena: 5, comment: "Sve pohvale za autosalon",),
            HistoryReviewTile(ocjena: 3),
            HistoryReviewTile(ocjena: 5, comment: "Sve pohvale za autosalon",),
            HistoryReviewTile(ocjena: 4),
          ],
        ),
       )
    );
  }
}