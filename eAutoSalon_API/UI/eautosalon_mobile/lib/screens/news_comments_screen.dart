import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class NewsComments extends StatefulWidget {
  const NewsComments({super.key});

  @override
  State<NewsComments> createState() => _NewsCommentsState();
}

class _NewsCommentsState extends State<NewsComments> {
  String test =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua";
  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'Komentari',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
               
              ],
            ),
          ),
        ));
  }

  Container buildCommentBox(String username, String comment) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 0.3, color: Colors.black87)),
                child: const Center(
                  child: Icon(
                    Icons.person_3,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                username.toUpperCase(),
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                    fontSize: 14),
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueGrey, width: 0.2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.comment,
                  color: Colors.black87,
                ),
                const SizedBox(height: 5),
                Text(
                  comment,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      wordSpacing: 1),
                )
              ],
            ),
          )
        ],
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
