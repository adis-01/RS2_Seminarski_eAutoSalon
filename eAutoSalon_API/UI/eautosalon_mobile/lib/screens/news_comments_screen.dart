// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_mobile/models/comment.dart';
import 'package:eautosalon_mobile/models/search_result.dart';
import 'package:eautosalon_mobile/providers/comment_provider.dart';
import 'package:eautosalon_mobile/utils/dialog_helper.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsComments extends StatefulWidget {
  final int novostId;
  final int korisnikId;
  const NewsComments({super.key, required this.novostId, required this.korisnikId});

  @override
  State<NewsComments> createState() => _NewsCommentsState();
}

class _NewsCommentsState extends State<NewsComments> {

  SearchResult<Comment>? result;
  late KomentarProvider _komentarProvider;
  final TextEditingController _commentController = TextEditingController();
  bool disabledCommentButton = true;
  bool isLoading = true;
  int currentPage = 1;
  final int _pageSize = 5;

  String test =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua";

  @override
  void initState() {
    super.initState();
    _komentarProvider=context.read<KomentarProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: 'Komentari',
        body: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black87),)
        :
         SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                (result?.totalPages ?? 0) > 0 ?
                 Column(
                 children: result?.list.map((Comment komentar) => buildCommentBox(komentar)).toList() ?? []
                ) : const Text("Nema komentara za ovu novost", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 17),),
                const SizedBox(height: 25),
                buildNewCommentBox(),
                const SizedBox(height: 25),
                (result?.totalPages ?? 0) > 0 ? buildPagingArrows() : const Text("")
              ]
            ),
          ),
        ));
  }

  Container buildNewCommentBox() {
    return Container(
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black54,
                    width: 0.3
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      width: double.infinity,
                      child: TextField(
                        cursorColor: Colors.black54,
                        controller: _commentController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Napišite komentar...',
                          hintStyle: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w400)
                        ),
                        onChanged: (value){
                          setState(() {
                            disabledCommentButton = value.isEmpty;
                          });
                        },
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.all(10),
                      color: Colors.black87,
                      disabledColor: Colors.grey[400],
                      onPressed:
                      !disabledCommentButton ?
                       (){
                        setState(() {
                          isLoading = true;
                          disabledCommentButton=true;
                        });
                        postComment();
                      } : null,
                      child: const Text("SAČUVAJ", textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),),
                      )
                  ],
                ),
              );
  }

  Container buildCommentBox(Comment object) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white60),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 0.3, color: Colors.black87)),
                child: const Center(
                  child: Icon(
                    Icons.person_2_sharp,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                object.komKorisnik?.toUpperCase() ?? "User unknown",
                style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    fontSize: 15),
              )
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            child: Text(object.sadrzaj ?? "Komentar null", style: const TextStyle(fontSize: 17, letterSpacing: 0.5, fontWeight: FontWeight.w500, color: Colors.black87),),
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
            onPressed:
            currentPage > 1
            ?
            () {
              setState(() {
                isLoading = true;
                currentPage--;
              });
              fetchData();
            } : null,
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
            onPressed:
            (result?.hasNext ?? false)
            ?
             () {
              setState(() {
                isLoading=true;
                currentPage++;
              });
              fetchData();
            }: null,
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
  
  Future<void> fetchData() async{
    try {
      var data = await _komentarProvider.getKomentare(widget.novostId, {'PageSize' : _pageSize, 'Page' : currentPage});
      setState(() {
        result=data;
        isLoading = false;
      });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
  
  Future<void> postComment() async{
    try {
      await _komentarProvider.insert({
        'sadrzaj' : _commentController.text,
        'korisnikId' : widget.korisnikId,
        'novostiId' : widget.novostId
      });
      MyDialogs.showSuccess(context, 'Uspješno dodan komentar', () {
        Navigator.of(context).pop();
        _commentController.clear();
        fetchData();
       });
    } catch (e) {
      MyDialogs.showError(context, e.toString());
    }
  }
}
