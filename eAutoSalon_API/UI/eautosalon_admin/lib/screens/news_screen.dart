
import 'package:eautosalon_admin/models/news.dart';
import 'package:eautosalon_admin/models/search_result.dart';
import 'package:eautosalon_admin/providers/news_provider.dart';
import 'package:eautosalon_admin/screens/news_details_screen.dart';
import 'package:eautosalon_admin/screens/your_news_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:eautosalon_admin/widgets/master_screen_editor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  
  SearchResult<News>? result;
  int currentPage = 1;
  final _pageSize = 3;
  bool isLoading = true;
  late NewsProvider _newsProvider;

  @override
  void initState() {
    super.initState();
    _newsProvider = context.read<NewsProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return EditorMasterScreen(
      isHomePage: true,
      title: 'Novosti drugih urednika',
       body: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.blueGrey,)) :
        SingleChildScrollView(
         child: Center(
          child: Container(
          padding: const EdgeInsets.all(25),
            child: Column(
              children: [
              buildEditorsNews(),
              const SizedBox(height: 20),
              Wrap(
                spacing: 15,
                runSpacing: 10,
                children: result?.list.map((News news) => buildContainer(context,news)).toList() ?? [],
              ),
              const SizedBox(height: 30),
              (result?.total ?? 0) > 0 ? buildPagingArrows() : const Text(""),
              ],
            ),
          ),
         ),
       )
       );
  }

  Row buildEditorsNews() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  MaterialButton(
                    color: Colors.blueGrey,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const EditorsNewsScreen()));
                    },
                    child: const Text("VAŠE NOVOSTI", style: TextStyle(fontSize: 14, letterSpacing: 1.3, color: Colors.white),),
                  ),
              ],
          );
  }

  Container buildContainer(BuildContext context, News item) {
    return Container(
                width: 350,
                height: 350,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white70,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      item.slika == "" ?  const SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Center(
                        child: Icon(Icons.no_photography, size: 50, color: Colors.black),
                      ),
                    ) : SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: fromBase64String(item.slika!),
                    ),
                    const SizedBox(height: 15),
                    Text(item.naslov ?? "null", style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 17)),
                    const SizedBox(height: 10),
                    Text(item.sadrzaj != "" ? item.sadrzaj!.length > 100 ? "${item.sadrzaj!.substring(0,100)}..." : item.sadrzaj! : "null", 
                    style: const TextStyle(fontSize: 15, color: Colors.blueGrey)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.tip?.toUpperCase() ?? "NULL", style: const TextStyle(fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.w500)),
                        Tooltip(
                          message: 'Više',
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black87
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => NewsDetailsScreen(editorsArticle: false, object: item)));
                                },
                                icon: const Icon(Icons.more_horiz, color: Colors.white, size: 20,),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
  }

  Row buildPagingArrows() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                minimumSize: const Size(60, 45),
                disabledBackgroundColor: Colors.grey),
            onPressed: currentPage > 1 ?
             (){
              setState(() {
                isLoading = true;
                currentPage--;
              });
              fetchData();
            } : null,
            child: const Icon(Icons.arrow_back, size: 20, color: Colors.white)),
        Text(
          "Stranica $currentPage od ${result?.total ?? "0"}",
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                minimumSize: const Size(60, 45),
                disabledBackgroundColor: Colors.grey),
            onPressed: (result?.hasNext ?? false) ?
                 () {
                    setState(() {
                      isLoading=true;
                      currentPage++;
                    });
                    fetchData();
                  } : null,
            child: const Icon(
              Icons.arrow_forward,
              size: 20,
              color: Colors.white,
            ))
      ],
    );
  }
  
  Future<void> fetchData() async{
    try {
      var data = await _newsProvider.getOstale({'username' : Authorization.username,'PageSize' : _pageSize, 'Page' : currentPage});
      setState(() {
        result = data;
        isLoading=false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }

}