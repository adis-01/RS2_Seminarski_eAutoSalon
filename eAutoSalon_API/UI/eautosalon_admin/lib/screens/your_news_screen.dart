import 'package:eautosalon_admin/models/news.dart';
import 'package:eautosalon_admin/models/search_result.dart';
import 'package:eautosalon_admin/providers/news_provider.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/utils/util.dart';
import 'package:eautosalon_admin/widgets/master_screen_editor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'news_details_screen.dart';

class EditorsNewsScreen extends StatefulWidget {
  const EditorsNewsScreen({super.key});

  @override
  State<EditorsNewsScreen> createState() => _EditorsNewsScreenState();
}

class _EditorsNewsScreenState extends State<EditorsNewsScreen> {
  SearchResult<News>? result;
  late NewsProvider _newsProvider;
  bool isLoading = true;
  int currentPage = 1;
  final _pageSize = 3;

  @override
  void initState() {
    super.initState();
    _newsProvider = context.read<NewsProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return EditorMasterScreen(
        title: 'Vaše novosti',
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: result?.list
                                  .map((News item) =>
                                      buildContainer(context, item))
                                  .toList() ??
                              [],
                        ),
                        const SizedBox(height: 30),
                        buildPagingArrows(),
                      ],
                    ),
                  ),
                ),
              ),
        isHomePage: false);
  }

  Container buildContainer(BuildContext context, News news) {
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
                        const SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Center(
                        child: Icon(Icons.no_photography, size: 50, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(news.naslov ?? "null", style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 17)),
                    const SizedBox(height: 10),
                    Text(news.sadrzaj != "" ? news.sadrzaj!.length > 100 ? "${news.sadrzaj!.substring(0,100)}..." : news.sadrzaj! : "null", 
                    style: const TextStyle(fontSize: 15, color: Colors.blueGrey)),
                      ],
                    ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(news.tip ?? "null",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic)),
              Tooltip(
                message: 'Detalji',
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black87),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => NewsDetailsScreen(
                                editorsArticle: true, object: news)));
                      },
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 20,
                      ),
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
            onPressed: currentPage > 1
                ? () {
                    setState(() {
                      currentPage--;
                      isLoading = true;
                    });
                    fetchData();
                  }
                : null,
            child: const Icon(Icons.arrow_back, size: 20, color: Colors.white)),
        Text(
          "Stranica $currentPage od ${result?.total ?? "null"}",
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
              size: 20,
              color: Colors.white,
            ))
      ],
    );
  }

  Future<void> fetchData() async {
    try {
      var data = await _newsProvider.getVlastite({
        'username': Authorization.username,
        'PageSize': _pageSize,
        'Page': currentPage
      });
      setState(() {
        result = data;
        isLoading = false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
