import 'dart:convert';

import 'package:eautosalon_mobile/models/news.dart';
import 'package:eautosalon_mobile/models/search_result.dart';
import 'package:eautosalon_mobile/providers/news_provider.dart';
import 'package:eautosalon_mobile/screens/news_detail_screen.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String tipNovosti = "Svi";
  final _formKey = GlobalKey<FormBuilderState>();
  SearchResult<News>? result;
  bool isLoading = true;
  late NewsProvider _newsProvider;
  int currentPage = 1;
  final int _pageSize = 3;

  @override
  void initState() {
    super.initState();
    _newsProvider = context.read<NewsProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
      title: 'Novosti',
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black87),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    FormBuilder(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [buildDropdownContainer()],
                      ),
                    ),
                    Column(
                      children: result?.list
                              .map((News object) => buildNewsContainer(object))
                              .toList() ??
                          [],
                    ),
                    const SizedBox(height: 25),
                    buildPagingArrows(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
    );
  }

  Container buildDropdownContainer() {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(top: 5, bottom: 20),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white70),
      child: FormBuilderDropdown(
          decoration: const InputDecoration(border: InputBorder.none),
          onChanged: (value) {
            if (value != null && value.isNotEmpty) {
              setState(() {
                tipNovosti = value;
                isLoading = true;
                currentPage = 1;
              });
              fetchData();
            }
          },
          name: 'TipNovosti',
          initialValue: tipNovosti,
          items: const [
            DropdownMenuItem(
              value: 'Svi',
              child: Text('Sve'),
            ),
            DropdownMenuItem(
              value: 'Novost',
              child: Text('Novosti'),
            ),
            DropdownMenuItem(
              value: 'Recenzija',
              child: Text('Recenzije'),
            ),
            DropdownMenuItem(
              value: 'Kolumna',
              child: Text('Kolumne'),
            )
          ]),
    );
  }

  Container buildNewsContainer(News item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 140,
            child: item.slika != "" ? fromBase64String(item.slika!) : const Center(child: Icon(Icons.no_photography, color: Colors.black54,),),
          ),
          const SizedBox(height: 10),
          Text(item.naslov ?? "null", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, letterSpacing: 0.8, color: Colors.grey[900]),),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.autor ?? "author unknown", style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500, letterSpacing: 0.5),),
              MaterialButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => NewsDetail(news: item)));
              },
              child: const Icon(Icons.more_horiz, color: Colors.black, size: 33,),)
            ],
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

  Future<void> fetchData() async {
    try {
      var data = await _newsProvider.getSve({
        'TipNovosti': tipNovosti,
        'PageSize': _pageSize,
        'Page': currentPage
      });
      if(mounted){
        setState(() {
        result = data;
        isLoading = false;
      });
      }
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}
