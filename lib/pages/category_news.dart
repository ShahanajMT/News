// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/showCategory_model.dart';
import 'package:news_app/services/showCategory.dart';

class CategoryNews extends StatefulWidget {
  String titleName;
  CategoryNews({
    Key? key,
    required this.titleName,
  }) : super(key: key);

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];

  bool isLoading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoryNews(widget.titleName.toLowerCase());
    categories = showCategoryNews.categories;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.titleName,
          style: const TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ShowCategory(image: categories[index].urlToImage!, desc: categories[index].description!, title: categories[index].title!);
          },
        ),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String image, desc, title;
  ShowCategory({
    Key? key,
    required this.image,
    required this.desc,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10,),
          Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),maxLines: 2,),
          const SizedBox(height: 4,),
          Text(desc,style:  TextStyle(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500, fontSize: 16),maxLines: 3,),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
