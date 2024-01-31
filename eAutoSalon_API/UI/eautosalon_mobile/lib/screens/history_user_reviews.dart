import 'package:eautosalon_mobile/providers/review_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/review.dart';
import '../widgets/master_screen.dart';
class HistoryReviews extends StatefulWidget {
  final int korisnikId;
  const HistoryReviews({super.key, required this.korisnikId});

  @override
  State<HistoryReviews> createState() => _HistoryReviewsState();
}

class _HistoryReviewsState extends State<HistoryReviews> {
  late List<Review> list = [];
  late ReviewProvider _reviewProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _reviewProvider = context.read<ReviewProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Vaše recenzije',
       body: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black87,),)
       :
       SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: list.isNotEmpty 
          ?
          Column(
            children: list.map((Review obj) => buildReviewBox(obj)).toList(),
          )
          : noDataContainer(),
        ),
       )
    );
  }

  Container buildReviewBox(Review review){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white70
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300]
              ),
              child: review.komentar != "" ?
                Text(review.komentar ?? "CAN NOT LOAD", style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 17),) 
              : const Text("Nema komentara", style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.star, color: Colors.yellow[700], size: 25,),
                const SizedBox(width: 5),
                Text(review.ocjena.toString(), style: const TextStyle(color: Colors.blueGrey,fontSize: 18, fontWeight: FontWeight.w600),)
              ],
            )
         ],
      ),
    );
  }

Center noDataContainer() {
    return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/car_icon.png",
                                width: 100,
                                height: 90,
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Do sada niste imali nijednu recenziju.",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 17,

                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        );
  }

  
  Future<void> fetchData() async{
    try {
      var data = await _reviewProvider.getHistory(widget.korisnikId);
      if(mounted){
      setState(() {
        list=data;
        isLoading = false;
      });
      }
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}