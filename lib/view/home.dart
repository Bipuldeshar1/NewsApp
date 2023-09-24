import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapi/view/description.dart';
import 'package:newsapi/view_model/newsviewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, independentNews, cnn, espn }

class _HomeScreenState extends State<HomeScreen> {
  FilterList? selectedMenu;
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');

  String name = 'espn';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.category,
                color: Colors.black,
              )),
          actions: [
            PopupMenuButton<FilterList>(
                initialValue: selectedMenu,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: (FilterList item) {
                  if (FilterList.espn.name == item.name) {
                    name == 'espn';
                  }
                  if (FilterList.aryNews.name == item.name) {
                    name = 'ary-news';
                  }
                  if (FilterList.cnn.name == item.name) {
                    name = 'cnn';
                  }
                  if (FilterList.espn.name == item.name) {
                    name = 'espn';
                  }
                  if (FilterList.bbcNews.name == item.name) {
                    name = 'bbc-News';
                  }
                  setState(() {});
                },
                itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                      PopupMenuItem(
                        value: FilterList.espn,
                        child: Text(
                          'espn',
                        ),
                      ),
                      PopupMenuItem(
                        value: FilterList.bbcNews,
                        child: Text(
                          'bbc',
                        ),
                      ),
                      // PopupMenuItem(
                      //   value: FilterList.aryNews,
                      //   child: Text(
                      //     'ary',
                      //   ),
                      // ),
                      PopupMenuItem(
                        value: FilterList.cnn,
                        child: Text(
                          'cnn',
                        ),
                      )
                    ])
          ],
          title: Center(
            child: Text(
              'News',
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * .58,
              width: width,
              child: FutureBuilder(
                future: newsViewModel.fetchNewChannelHeadlinesApi(name),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Description(
                                            title: snapshot
                                                .data!.articles![index].title,
                                            img: snapshot.data!.articles![index]
                                                .urlToImage,
                                            des: snapshot.data!.articles![index]
                                                .description,
                                          )));
                            },
                            child: SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: height * 0.6,
                                    width: width * .9,
                                    // padding: EdgeInsets.symmetric(
                                    //     horizontal: height * .1),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                        )
                                        // CachedNetworkImage(
                                        //   imageUrl:
                                        //       "https://static.dw.com/image/65611306_6.jpg",
                                        //   //  snapshot
                                        //   //     .data!.articles![index].urlToImage
                                        //   //     .toString(),

                                        //   fit: BoxFit.cover,
                                        //   placeholder: (context, url) =>
                                        //       CircularProgressIndicator(),
                                        //   errorWidget: (context, url, error) =>
                                        //       Icon(Icons.error),
                                        // ),
                                        ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        padding: EdgeInsets.all(15),
                                        height: height * .22,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * 0.7,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString()),
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                  Text(format.format(dateTime)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
                height: 500,
                child: FutureBuilder(
                    future: newsViewModel.fetchNewChannelHeadlinesApi(name),
                    builder: (context, snapashot) {
                      if (snapashot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var snp = snapashot.data!.articles![index];

                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Description(
                                              title: snp.title,
                                              img: snp.urlToImage,
                                              des: snp.description,
                                            )));
                              },
                              leading: Image.network(snp.urlToImage.toString()),
                              title: Text(snp.title.toString()),
                            );
                          },
                          itemCount: snapashot.data!.articles!.length,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    })),
          ],
        ));
  }
}
