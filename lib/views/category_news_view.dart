import 'package:FlutterNewsApp/providers/news_model_provider.dart';
import 'package:FlutterNewsApp/widgets/blog_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryNewsView extends StatefulWidget {
  @override
  _CategoryNewsViewState createState() => _CategoryNewsViewState();
}

class _CategoryNewsViewState extends State<CategoryNewsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsModelProvider>(context, listen: false)
          .getNews(category: 'health');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsModelProvider>(
      builder: (context, category, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 30,
              ),
            ),
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: category.allNews.length,
                  itemBuilder: (context, index) {
                    return BlogTile(
                      title: category.allNews[index].title,
                      description: category.allNews[index].description,
                      imgUrl: category.allNews[index].urlToImage,
                      url: category.allNews[index].url,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
