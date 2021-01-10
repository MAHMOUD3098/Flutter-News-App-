import 'package:FlutterNewsApp/providers/category_model_provider.dart';
import 'package:FlutterNewsApp/widgets/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<CategoryModelProvider>(
      builder: (consumerContext, categoryModel, child) {
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
                        itemCount: categoryModel.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            categoryName:
                                categoryModel.categories[index].categoryName,
                            imageUrl: categoryModel.categories[index].imgUrl,
                          );
                        },
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
