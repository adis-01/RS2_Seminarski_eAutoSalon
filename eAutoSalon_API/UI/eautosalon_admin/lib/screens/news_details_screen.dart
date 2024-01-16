import 'package:eautosalon_admin/providers/comment_provider.dart';
import 'package:eautosalon_admin/screens/news_comments_screen.dart';
import 'package:eautosalon_admin/utils/dialogs.dart';
import 'package:eautosalon_admin/widgets/master_screen_editor.dart';
import 'package:eautosalon_admin/widgets/news_edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/news.dart';

class NewsDetailsScreen extends StatefulWidget {
  News object;
  bool editorsArticle;
  NewsDetailsScreen(
      {super.key, required this.editorsArticle, required this.object});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool isLoading = true;
  String text =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Massa vitae tortor condimentum lacinia quis vel eros donec. Eros in cursus turpis massa tincidunt dui. Duis convallis convallis tellus id interdum velit laoreet id donec. Vel pharetra vel turpis nunc eget. Purus sit amet luctus venenatis lectus magna. Risus viverra adipiscing at in tellus integer feugiat scelerisque. Ac orci phasellus egestas tellus rutrum. Praesent semper feugiat nibh sed pulvinar proin. Amet tellus cras adipiscing enim eu turpis egestas pretium aenean. Fermentum et sollicitudin ac orci phasellus. Massa ultricies mi quis hendrerit dolor magna eget est. Diam phasellus vestibulum lorem sed risus ultricies tristique nulla. Et malesuada fames ac turpis egestas. Est pellentesque elit ullamcorper dignissim. Semper viverra nam libero justo. Laoreet id donec ultrices tincidunt. Dictum varius duis at consectetur lorem donec massa sapien. Feugiat in fermentum posuere urna nec tincidunt praesent semper. Facilisi etiam dignissim diam quis enim lobortis scelerisque fermentum. Convallis a cras semper auctor neque. Lobortis elementum nibh tellus molestie nunc. Cras adipiscing enim eu turpis egestas pretium aenean pharetra magna. Massa vitae tortor condimentum lacinia quis. Nec tincidunt praesent semper feugiat nibh sed pulvinar proin gravida. Egestas congue quisque egestas diam in arcu cursus. Pharetra massa massa ultricies mi quis hendrerit dolor magna eget. Cursus metus aliquam eleifend mi in nulla posuere.Lectus urna duis convallis convallis. Interdum posuere lorem ipsum dolor. Aliquam nulla facilisi cras fermentum. Faucibus ornare suspendisse sed nisi. Quis vel eros donec ac odio tempor orci dapibus. Pellentesque habitant morbi tristique senectus et netus et malesuada. Varius morbi enim nunc faucibus a. Nisl tincidunt eget nullam non nisi est sit amet facilisis. Molestie nunc non blandit massa. Volutpat sed cras ornare arcu dui. Malesuada fames ac turpis egestas. Viverra orci sagittis eu volutpat odio facilisis. Nisl purus in mollis nunc sed id. Aliquet porttitor lacus luctus accumsan tortor. Bibendum ut tristique et egestas. Maecenas pharetra convallis posuere morbi leo urna molestie. Congue quisque egestas diam in. Vitae purus faucibus ornare suspendisse sed nisi lacus sed viverra. Ac placerat vestibulum lectus mauris. Viverra tellus in hac habitasse platea dictumst vestibulum.";
  int? totalNoOfComments;
  late KomentarProvider _komentarProvider;

  @override
  void initState() {
    super.initState();
    _komentarProvider = context.read<KomentarProvider>();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return EditorMasterScreen(
      isHomePage: false,
      title: 'Detalji',
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  width: 830,
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.only(top: 65, bottom: 65),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.newspaper,
                              color: Colors.black, size: 25),
                          widget.editorsArticle ? Tooltip(
                            message: 'Uredi',
                            child: IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const EditNewsDialog());
                              },
                              icon: const Icon(Icons.edit,
                                  color: Colors.black, size: 25),
                            ),
                          ) : const Text("")
                        ],
                      ),
                      const SizedBox(height: 10),
                      buildImage(),
                      const SizedBox(height: 10),
                      Text(widget.object.naslov?.toUpperCase() ?? "NULL",
                          style: const TextStyle(
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              fontSize: 25)),
                      const SizedBox(height: 10),
                      buildAuthorDate(),
                      const SizedBox(height: 15),
                      Text(text,
                          style: const TextStyle(
                              color: Colors.blueGrey, fontSize: 17)),
                      const SizedBox(height: 15),
                      const Divider(thickness: 0.3, color: Colors.blueGrey),
                      const SizedBox(height: 10),
                      buildCommsButton()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Container buildImage() {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey, width: 0.2),
          borderRadius: BorderRadius.circular(5),
        ),
        width: double.infinity,
        height: 235,
        child: const Center(
          child: Icon(
            Icons.no_photography,
            size: 50,
            color: Colors.black87,
          ),
        ));
  }

  Row buildAuthorDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueGrey, width: 0.3)),
            child: const Center(
                child: Icon(
              Icons.person_2,
              color: Colors.blueGrey,
              size: 28,
            ))),
        const SizedBox(width: 10),
        const Text("A U T H O R",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.blueGrey)),
        const SizedBox(width: 35),
        const Icon(Icons.date_range, size: 28, color: Colors.blueGrey),
        const SizedBox(width: 10),
        Text(widget.object.date,
            style: const TextStyle(
                fontSize: 13,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold)),
        const SizedBox(width: 35),
        const Icon(Icons.sort, size: 28, color: Colors.blueGrey),
        const SizedBox(width: 10),
        Text(widget.object.tip?.toUpperCase() ?? "tip",
            style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 13,
                fontWeight: FontWeight.bold))
      ],
    );
  }

  Center buildCommsButton() {
    return Center(
      child: SizedBox(
        width: 380,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black38),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => CommentsScreen(
                      isOwner: widget.editorsArticle,
                      novostId: widget.object.novostiId ?? 0,
                    )));
          },
          child: Text("Komentari ($totalNoOfComments)",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.5)),
        ),
      ),
    );
  }

  Future<void> loadData() async {
    try {
      totalNoOfComments = await _komentarProvider.getTotalComms(widget.object.novostiId!);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      CustomDialogs.showError(context, e.toString());
    }
  }
}
