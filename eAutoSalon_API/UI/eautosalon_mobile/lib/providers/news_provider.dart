
import 'package:eautosalon_mobile/models/news.dart';
import 'base_provider.dart';

class NewsProvider extends BaseProvider<News>{

  NewsProvider() : super("Novosti");


  @override
  News fromJson(object) {
    return News.fromJson(object);
  }
}