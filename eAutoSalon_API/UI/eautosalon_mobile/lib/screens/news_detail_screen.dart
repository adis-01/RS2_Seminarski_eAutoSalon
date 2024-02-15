import 'package:eautosalon_mobile/screens/news_comments_screen.dart';
import 'package:eautosalon_mobile/utils/helpers.dart';
import 'package:eautosalon_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

import '../models/news.dart';

class NewsDetail extends StatefulWidget {
  final News news;
  const NewsDetail({super.key, required this.news});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {



  final String _lorem =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquam malesuada bibendum arcu vitae elementum curabitur vitae. Aenean pharetra magna ac placerat vestibulum lectus mauris ultrices. Sollicitudin aliquam ultrices sagittis orci a scelerisque purus. Facilisis volutpat est velit egestas dui. Tristique risus nec feugiat in fermentum posuere urna. Viverra tellus in hac habitasse platea dictumst vestibulum rhoncus est. Viverra justo nec ultrices dui sapien eget. Sit amet justo donec enim diam. Non arcu risus quis varius quam quisque id. Nunc consequat interdum varius sit amet mattis. Pharetra et ultrices neque ornare aenean euismod elementum nisi quis. Nunc scelerisque viverra mauris in aliquam sem fringilla ut morbi. Nibh nisl condimentum id venenatis a condimentum. Ornare massa eget egestas purus viverra accumsan in nisl. Non tellus orci ac auctor augue mauris augue. Turpis in eu mi bibendum neque egestas. Tristique senectus et netus et malesuada fames ac turpis egestas. In nibh mauris cursus mattis molestie a iaculis at erat. Sit amet nisl suscipit adipiscing bibendum est ultricies integer quis. Sed ullamcorper morbi tincidunt ornare. Vivamus arcu felis bibendum ut tristique et egestas. Natoque penatibus et magnis dis. Fringilla ut morbi tincidunt augue interdum velit euismod in. Habitasse platea dictumst vestibulum rhoncus est pellentesque elit ullamcorper dignissim. Ullamcorper eget nulla facilisi etiam dignissim. Viverra suspendisse potenti nullam ac tortor vitae purus. Ullamcorper malesuada proin libero nunc consequat interdum varius sit. At erat pellentesque adipiscing commodo elit.";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyAppBar(
        title: '',
        body:
         SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                //naslov
                 Text(
                 widget.news.naslov ?? "Naslov null",
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      wordSpacing: 1,
                      fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                //slika
                buildImage(),
                //podaci
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //autor
                          buildAuthorCreds(),
                          const SizedBox(width: 3),
                          const Text("|"),
                          const SizedBox(width:3),
                          //datum
                          buildDate(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        thickness: 0.2,
                        color: Colors.black87,
                      ),
                      const SizedBox(height: 10),
                      const Icon(
                        Icons.article,
                        color: Colors.black87,
                      ),
                      const SizedBox(height: 8),
                      buildText(),
                      const SizedBox(height: 10),
                      const Divider(thickness: 0.2, color: Colors.black87,),
                      const SizedBox(height: 10),
                      buildCommentsButton()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  GestureDetector buildCommentsButton() {
    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => NewsComments(novostId: widget.news.novostiId!)));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black54),
                        child: Text(
                          "KOMENTARI",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              letterSpacing: 1.5,
                              color: Colors.grey[300],
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
  }

  Text buildText() {
    return Text(
      widget.news.sadrzaj == "" ? _lorem : widget.news.sadrzaj!,
      style: const TextStyle(
          height: 1.35,
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5),
    );
  }

  Row buildDate() {
    return Row(
      children: [
        Text(
          widget.news.datum ?? "null",
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 13
          ),
        )
      ],
    );
  }

  Row buildAuthorCreds() {
    return Row(
      children: [
        Text(
          widget.news.korisnik?.fullname ?? "null",
          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 13),
        )
      ],
    );
  }

  Container buildImage() {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.news.slika == "" ?
         const Center(
          child: Icon(
            Icons.no_photography,
           size: 55,
            color: Colors.black87,
          ),
        ) : fromBase64String(widget.news.slika!),
      ),
    );
  }
  
}
