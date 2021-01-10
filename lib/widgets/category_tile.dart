import 'package:FlutterNewsApp/providers/category_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              imageUrl,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Text(
              categoryName,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
