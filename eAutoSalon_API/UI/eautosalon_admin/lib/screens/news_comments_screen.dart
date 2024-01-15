
import 'package:eautosalon_admin/widgets/master_screen_editor.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

  bool isLoading = true;
  bool disableCommentButton = true;
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return EditorMasterScreen(
      title: 'Komentari',
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  width: 650,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          buildComment(),
                        ],
                      ),
                      buildCommentBox()
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                buildPagingArrows()
              ],
            ),
          ),
        ),
      ),
      isHomePage: false);
  }

  Container buildCommentBox() {
    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 0.1,
                          color: Colors.black54
                        )
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: _commentController,
                              onChanged: (value){
                                setState(() {
                                  disableCommentButton = value.isEmpty;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                                hintText: 'Napišite komentar...',
                                hintStyle: const TextStyle(color: Colors.blueGrey)
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 130,
                            height: 35,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
                              onPressed: !disableCommentButton ? (){
                                print(_commentController.text);
                              } : null,
                              child: const Text("Komentariši", style: TextStyle(fontSize: 13, color: Colors.white),),
                            ),
                          )
                        ],
                      ),
                    );
  }

  Container buildComment() {
    return Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 0.2,
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
                              const SizedBox(width: 7),
                              const Text("P E R S O N", style: TextStyle(fontSize: 14, color: Colors.blueGrey, fontWeight: FontWeight.w500),)
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Divider(thickness: 0.3, color: Colors.blueGrey),
                          const SizedBox(height: 2),
                          const Text("S A D R Ž A J    K O M E N T A R A", style: TextStyle(color: Colors.blueGrey, fontSize: 15)),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.delete, color: Colors.red[300], size: 22)
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
            onPressed:(){},
            child: const Icon(Icons.arrow_back, size: 20, color: Colors.white)),
        const Text(
          "Stranica 1 od 100",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                minimumSize: const Size(60, 45),
                disabledBackgroundColor: Colors.grey),
            onPressed:
                 () {
                    
                  },
            child: const Icon(
              Icons.arrow_forward,
              size: 20,
              color: Colors.white,
            ))
      ],
    );
  }

}