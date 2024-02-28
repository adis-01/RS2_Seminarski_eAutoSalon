// ignore_for_file: use_build_context_synchronously


import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

import '../utils/helpers.dart';

class ReviewInsert extends StatefulWidget {
  const ReviewInsert({super.key});

  @override
  State<ReviewInsert> createState() => _ReviewInsertState();
}

class _ReviewInsertState extends State<ReviewInsert> {
  int currentRating = 1;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: '',
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Podijelite svoja iskustva sa drugima",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Da li ste zadovoljni uslugom?",
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5),
                ),
                const SizedBox(height: 30),
                buildStars(),
                buildCommentBox(),
                buildButton(),
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.6),
                      borderRadius: BorderRadius.circular(13)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.info,
                        color: Colors.blue,
                        size: 23,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Odaberite zvjezdicu (1-5) kako biste dali odgovarajuću ocjenu, a unos spasite klikom na dugme",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.blueGrey,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  GestureDetector buildButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop({
          'Ocjena': currentRating,
          'Komentar': _commentController.text,
          'KorisnikId': Authorization.userId,
          'State' : 'Aktivna'
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black87, Colors.grey])),
        child: const Text(
          "SAČUVAJ",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 1,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Container buildCommentBox() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueGrey, width: 0.5),
      ),
      child: TextField(
        controller: _commentController,
        cursorColor: Colors.grey,
        decoration: const InputDecoration(
            border: InputBorder.none,
            counter: Icon(
              Icons.comment,
              size: 23,
              color: Colors.black54,
            ),
            hintText: 'Ukoliko želite, ostavite i komentar...',
            hintStyle: TextStyle(color: Colors.black54, fontSize: 17)),
        minLines: 3,
        maxLines: 6,
      ),
    );
  }

  Row buildStars() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          5,
          (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    currentRating = index + 1;
                  });
                },
                child: Icon(
                  Icons.star,
                  color: index < currentRating
                      ? Colors.yellow[800]
                      : Colors.grey[600],
                  size: 40,
                ),
              )),
    );
  }
}
