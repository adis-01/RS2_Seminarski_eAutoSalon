// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/models/search_result.dart';
import 'package:eautosalon_admin/providers/review_provider.dart';
import 'package:eautosalon_admin/screens/home_page_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/review.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {

  double? average;
  int currentPage = 1;
  final _pageSize = 6;
  SearchResult<Review>? result;
  late ReviewProvider _reviewProvider;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _reviewProvider = context.read<ReviewProvider>();
    loadData();
  }


  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        title: 'Recenzije korisnika',
        body: Container(
          padding: const EdgeInsets.all(25),
          child: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.blueGrey,))
          : SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBack(context),
                    Row(
                      children: [
                        Tooltip(
                          message: 'Prosječna ocjena',
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueGrey
                            ),
                            child: const Center(
                              child: Icon(Icons.star, color: Colors.white, size: 26,),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          margin: const EdgeInsets.only(right: 25),
                          child: Text("${average?.toStringAsFixed(2) ?? 0}", style: const TextStyle(fontSize: 19, color: Colors.black87, fontWeight: FontWeight.bold),))
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                (result?.total ?? 0) != 0 ?
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: 
                   result?.list.map((Review review) => buildReviewBox(context, review) ).toList() ?? []
                ) : const Center(child: Text("NO DATA", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 18),),),
                const SizedBox(height: 35),
               (result?.total ?? 0) != 0 ? buildPaginationArrows() : const Text("")
              ],
            ),
          ),
        ),
        floatingEnabled: false);
  }

  Container buildReviewBox(BuildContext context, Review object) {
    return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white70),
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
                              border: Border.all(
                                color: Colors.black54,
                                width: 0.3
                              ),
                              shape: BoxShape.circle
                            ),
                            child: const Center(
                              child: Icon(Icons.person, color: Colors.black87,),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(object.korisnik?.username ?? "", style: const TextStyle(fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 22, color: Colors.yellow[800]),
                          const SizedBox(width: 5),
                          Text(object.ocjena?.toString() ?? "0", style: const TextStyle(fontSize: 17, color: Colors.black87,fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  object.komentar != null ? Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 0.3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(object.komentar ?? "", style: const TextStyle(fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.w600),),
                  ) : const Center(child: Text("KOMENTAR NIJE OSTAVLJEN",style: TextStyle(fontSize: 15, color: Colors.blueGrey),)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Tooltip(
                        message: 'Obriši',
                        child: IconButton(
                          splashRadius: 20,
                          onPressed: (){
                            CustomDialogs.showQuestion(context, 'Izbrisati recenziju korisnika ${object.korisnik?.username ?? "null"}?', () async{
                                await _reviewProvider.delete(object.recenzijaId!);
                                Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const ReviewsScreen()));
                             });
                          }, icon: Icon(Icons.delete, color: Colors.red[400], size: 23)),
                      )
                    ],
                  )
                ],
              ),
            );
  }

  SizedBox buildPaginationArrows() {
    return SizedBox(
              width: 550,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    color: Colors.black87,
                    disabledColor: Colors.grey[400],
                    padding: const EdgeInsets.all(13),
                    onPressed: currentPage > 1 ? (){
                      setState(() {
                        currentPage--;
                        isLoading=true;
                      });
                      loadData();
                    } : null,
                    child: const Icon(Icons.arrow_back, color: Colors.white,),),
                  Text("Stranica $currentPage od ${result?.total ?? "null"}", style: const TextStyle(fontSize: 16, color: Colors.blueGrey,fontWeight: FontWeight.bold),),
                  MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    color: Colors.black87,
                    disabledColor: Colors.grey[400],
                    padding: const EdgeInsets.all(13),
                    onPressed: (result?.hasNext ?? false) ?
                     (){
                      setState(() {
                        currentPage++;
                        isLoading=true;
                      });
                      loadData();
                    } : null,
                    child: const Icon(Icons.arrow_forward, color: Colors.white,),),
                ],
              ),
            );
  }

  MaterialButton buildBack(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(15),
      color: Colors.blueGrey,
      shape: const CircleBorder(),
      onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (builder) => const HomePageScreen()));
      },
      child: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    );
  }
  
  Future<void> loadData() async{
    try {
      var data = await _reviewProvider.getPaged({'Page': currentPage, 'PageSize' : _pageSize});
      var avg = await _reviewProvider.getAverage();
      setState(() {
        result = data;
        average = avg;
        isLoading = false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
