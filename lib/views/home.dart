import 'package:FlutterNewsApp/providers/article_model_provider.dart';
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
      Provider.of<ArticleModelProvider>(context, listen: false).getNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<ArticleModelProvider>(
      builder: (context, article, child) {
        return article.isLoaded == false
            ? SafeArea(
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
                                  imageUrl: Constants.categories[index].imgUrl,
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              child: Container(
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: article.news.length,
                                    itemBuilder: (context, index) {
                                      return BlogTile(
                                        title: article.news[index].title,
                                        description:
                                            article.news[index].description,
                                        imgUrl: article.news[index].imgUrl,
                                        url: article.news[index].url,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
