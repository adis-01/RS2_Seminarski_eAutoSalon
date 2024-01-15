
import 'package:eautosalon_admin/screens/news_details_screen.dart';
import 'package:eautosalon_admin/widgets/master_screen_editor.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return EditorMasterScreen(
      isHomePage: true,
      title: 'Novosti',
       body: SingleChildScrollView(
         child: Center(
          child: Container(
          padding: const EdgeInsets.all(25),
            child: Column(
              children: [
              buildEditorsNews(),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  buildContainer(context)
                ],
              ),
              const SizedBox(height: 30),
              buildPagingArrows(),
              ],
            ),
          ),
         ),
       )
       );
  }

  Row buildEditorsNews() {
    return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Tooltip(
                  message: 'Vaše novosti',
                  child: MaterialButton(
                    color: const Color(0xFF248BD6),
                    padding: const EdgeInsets.all(15),
                    shape: const CircleBorder(),
                    onPressed: (){
                
                    },
                    child: const Icon(Icons.newspaper_outlined, color: Colors.white),
                  ),
                )
              ],
          );
  }

  Container buildContainer(BuildContext context) {
    return Container(
                width: 350,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white70,
                ),
                child: Column(
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
                    const Text("N A S L O V", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 17)),
                    const SizedBox(height: 10),
                    const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Massa vitae tortor condimentum lacinia quis...", style: TextStyle(fontSize: 15, color: Colors.blueGrey)),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Tooltip(
                          message: 'Detalji',
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black87
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const NewsDetailsScreen()));
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