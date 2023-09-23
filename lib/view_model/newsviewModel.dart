import 'package:newsapi/model/newsmodel.dart';
import 'package:newsapi/repository/newsrepository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  // Future<NewsChannelHeadlinesModel> fetchNewsHeadlines() async {
  //   final response = await _rep.fetchNewsHeadlines();
  //   print(response.toString());
  //   return response;
  // }
  Future<NewsChannelHeadlinesModel> fetchNewChannelHeadlinesApi(
      String channelName) async {
    final response = await _rep.fetchNewChannelHeadlinesApi(channelName);
    return response;
  }
}
