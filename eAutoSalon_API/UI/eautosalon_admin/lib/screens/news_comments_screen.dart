
// ignore_for_file: use_build_context_synchronously

import 'package:eautosalon_admin/models/comment.dart';
import 'package:eautosalon_admin/providers/comment_provider.dart';
import 'package:eautosalon_admin/screens/news_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen_editor.dart';
import 'package:eautosalon_admin/widgets/new_comment_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/search_result.dart';

class CommentsScreen extends StatefulWidget {
  int novostId;
  bool isOwner;
  CommentsScreen({super.key, required this.isOwner, required this.novostId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  SearchResult<Comment>? result;
  final _pageSize = 4;
  int currentPage = 1;
  bool isLoading = true;
  bool disableCommentButton = true;
  late KomentarProvider _komentarProvider;

  @override
  void initState() {
    super.initState();
    _komentarProvider = context.read<KomentarProvider>();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return EditorMasterScreen(
      title: 'Komentari',
      body: isLoading ?  const Center(child: CircularProgressIndicator())
      : Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: 700,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.3,
                      color: Colors.blueGrey
                    ),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (result?.total ?? 0) > 0 ? 
                         Column(
                          children: 
                          result?.list.map((Comment item) => buildComment(context, item)).toList() ?? []
                        ) : const Center(child: Text("Nema komentara", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blueGrey),),),
                        const SizedBox(height: 15),
                        buildCommentButton()
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                (result?.total ?? 0) > 0 ? buildPagingArrows() : const Text("")
              ],
            ),
          ),
        ),
      ),
      isHomePage: false);
  }

  Row buildCommentButton() {
    return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            color: Colors.black54,
                            padding: const EdgeInsets.all(20),
                            onPressed: (){
                              showDialog(context: context, builder: (context) => NewCommentDialog(novostId: widget.novostId));
                            },
                            child: const Text("Napišite komentar", style: TextStyle(fontWeight: FontWeight.w500 , color: Colors.white))
                          ),
                        ],
                      );
  }


  Container buildComment(BuildContext context, Comment item) {
    return Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(Icons.person, color: Colors.black87),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(item.komKorisnik, style: const TextStyle(fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.w600),)
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Divider(thickness: 0.3, color: Colors.blueGrey),
                          const SizedBox(height: 2),
                          Text(item.sadrzaj ?? "null", style: const TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              widget.isOwner ? Tooltip(
                                message: 'Izbriši komentar',
                                child: IconButton( 
                                  splashRadius: 20,
                                  onPressed: (){
                                    CustomDialogs.showQuestion(context, 'Izbrisati komentar korisnika ${item.komKorisnik}?', () async{
                                        await _komentarProvider.delete(item.komentarId!);
                                        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const NewsScreen()));
                                     });
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red[300], size: 22)
                                ),
                              ) : const Text(""),
                            ],
                          )
                        ],
                      ),
                    );
  }


  Row buildPagingArrows() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                minimumSize: const Size(60, 45),
                disabledBackgroundColor: Colors.grey),
            onPressed: currentPage > 1 ? (){
              setState(() {
                isLoading = true;
                currentPage--;
              });
              fetchData();
            } : null,
            child: const Icon(Icons.arrow_back, size: 20, color: Colors.white)),
        const SizedBox(width: 55),
        Text(
          "Stranica $currentPage od ${result?.total ?? 0}",
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
        const SizedBox(width: 55),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                minimumSize: const Size(60, 45),
                disabledBackgroundColor: Colors.grey),
            onPressed:
                (result?.hasNext ?? false) ? () {
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
      var data = await _komentarProvider.komentarNovost(widget.novostId,{'PageSize' : _pageSize, 'Page' : currentPage});
      result = data;  
      setState(() {
        isLoading=false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }

}