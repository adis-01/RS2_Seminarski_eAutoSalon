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
       body: Center(
        child: Text("HISTORIJA RECENZIJA"),
       )
    );
  }
}