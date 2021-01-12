import 'package:FlutterNewsApp/providers/news_model_provider.dart';
import 'package:FlutterNewsApp/utilities/constants.dart';
import 'package:FlutterNewsApp/widgets/blog_tile.dart';
import 'package:FlutterNewsApp/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsModelProvider>(context, listen: false).getNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<NewsModelProvider>(
      builder: (context, news, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Flutter',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'News',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 0.08 * screenHeight,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: Constants.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            categoryName:
                                Constants.categories[index].categoryName,
                            imageUrl: Constants.categories[index].imageUrl,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: news.isLoaded == false
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              child: Container(
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: news.allNews.length,
                                    itemBuilder: (context, index) {
                                      return BlogTile(
                                        title: news.allNews[index].title,
                                        description:
                                            news.allNews[index].description,
                                        imgUrl: news.allNews[index].urlToImage,
                                        url: news.allNews[index].url,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.green),
                              ),
                              width: screenWidth,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
