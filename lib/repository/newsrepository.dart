import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapi/model/newsmodel.dart';

class NewsRepository {
  // Future<NewsChannelHeadlinesModel> fetchNewsHeadlines() async {
  //   try {
  //     String url =
  //         'https://newsapi.org/v2/top-headlines?country=us&apiKey=cd34c5768cab4dcaae9f5e68826c7c56';

  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       final body = jsonDecode(response.body);
  //       // print(body.toString());
  //       return NewsChannelHeadlinesModel.fromJson(body);
  //     } else {
  //       throw Exception('Failed to fetch news headlines');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception('An error occurred while fetching news headlines');
  //   }
  // }
  Future<NewsChannelHeadlinesModel> fetchNewChannelHeadlinesApi(
      String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=cd34c5768cab4dcaae9f5e68826c7c56';
    print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
