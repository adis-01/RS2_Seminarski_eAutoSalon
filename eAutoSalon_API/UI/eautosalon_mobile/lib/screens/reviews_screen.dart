import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:eautosalon_mobile/widgets/review_dialog.dart';
import 'package:eautosalon_mobile/widgets/review_tile.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'Recenzije',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [buildReviewButton()],
                    ),
                    buildAverageReview()
                  ],
                ),
                const SizedBox(height: 20),
                ReviewTile(
                  username: 'savin0',
                  ocjena: 5,
                  komentar: "Odličan članak",
                ),
                ReviewTile(username: 'marl0', ocjena: 3),
                ReviewTile(
                  username: 'savin0',
                  ocjena: 5,
                  komentar: "Odličan članak",
                ),
                ReviewTile(
                  username: 'savin0',
                  ocjena: 5,
                  komentar: "Odličan članak",
                ),
                ReviewTile(username: 'marl0', ocjena: 3),
                ReviewTile(
                  username: 'savin0',
                  ocjena: 5,
                  komentar: "Odličan članak",
                ),
                ReviewTile(username: 'marl0', ocjena: 3),
                const SizedBox(height: 20),
                buildPagingArrows()
              ],
            ),
          ),
        ));
  }

  Row buildAverageReview() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Colors.black54),
          child: const Center(
              child: Icon(
            Icons.star,
            color: Colors.white,
          )),
        ),
        const SizedBox(width: 10),
        const Text(
          "3.56",
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.5),
        )
      ],
    );
  }

  GestureDetector buildReviewButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context, builder: (context) => const ReviewDialog());
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.black87),
        child: const Text(
          "OSTAVITE RECENZIJU",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ),
    );
  }

  Row buildPagingArrows() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 60,
          height: 40,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.black87,
            disabledColor: Colors.grey[400],
            padding: const EdgeInsets.all(5),
            onPressed: () {},
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        const Text(
          "1/1",
          style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
        SizedBox(
          width: 60,
          height: 40,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Colors.black87,
            disabledColor: Colors.grey[400],
            padding: const EdgeInsets.all(5),
            onPressed: () {},
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
