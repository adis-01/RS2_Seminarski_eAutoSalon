// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_mobile/models/search_result.dart';
import 'package:eautosalon_mobile/providers/review_provider.dart';
import 'package:eautosalon_mobile/screens/review_insert_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/review.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  double average = 0.00;
  bool isLoading = true;
  late ReviewProvider _reviewProvider;
  final int _pageSize = 4;
  int currentPage = 1;
  SearchResult<Review>? result;

  @override
  void initState() {
    super.initState();
    _reviewProvider = context.read<ReviewProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'Recenzije',
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black87,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [buildAverage(), buildButton()],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: result?.list
                                .map(
                                    (Review item) => buildReviewContainer(item))
                                .toList() ??
                            [],
                      ),
                      const SizedBox(height: 20),
                      buildPagingArrows()
                    ],
                  ),
                ),
              ));
  }

  GestureDetector buildButton() {
    return GestureDetector(
      onTap: () async {
        var result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (builder) => const ReviewInsert()));
        if (result != null) {
          setState(() {
            isLoading = true;
          });
          saveData(result);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey[900]),
        child: Row(
          children: const [
            Text(
              "Recenzirajte",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.5,
                  color: Colors.white),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.arrow_forward,
              size: 20,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Row buildAverage() {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 27,
          color: Colors.yellow[800],
        ),
        const SizedBox(width: 3),
        Text(
          "${average.toStringAsFixed(2)} / 5.0",
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
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
            onPressed: currentPage > 1
                ? () {
                    setState(() {
                      currentPage--;
                      isLoading = true;
                    });
                    fetchData();
                  }
                : null,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          "$currentPage/${result?.totalPages ?? "null"}",
          style: const TextStyle(
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
            onPressed: (result?.hasNext ?? false)
                ? () {
                    setState(() {
                      currentPage++;
                      isLoading = true;
                    });
                    fetchData();
                  }
                : null,
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Container buildReviewContainer(Review object) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.3, color: Colors.black87),
                        shape: BoxShape.circle),
                    child: const Center(
                        child: Icon(
                      Icons.person,
                      color: Colors.blueGrey,
                    )),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    object.username ?? "null",
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[800],
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    object.ocjena.toString(),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 5),
          Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: object.komentar == ""
                  ? const Text(
                      'Korisnik nije ostavio komentar',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                          fontSize: 16),
                    )
                  : Text(
                      object.komentar ?? "no data",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey),
                    ))
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      var data = await _reviewProvider
          .getPaged({'PageSize': _pageSize, 'Page': currentPage});
      var avg = await _reviewProvider.getAverage();
      if (mounted) {
        setState(() {
          result = data;
          isLoading = false;
          average = avg;
        });
      }
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }

  Future<void> saveData(dynamic object) async {
    try {
      await _reviewProvider.insert(object);
      MyDialogs.showSuccess(context,
          'Hvala na odvojenom vremenu i recenziji, na ovaj način doprinosite radu i poboljšanju auto salona',
          () {
        Navigator.of(context).pop();
        fetchData();
      });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}
