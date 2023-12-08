// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/category_news.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/services/data.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // for catogory -> Business, Sports, Health etc...
  List<CategoryModel> categories = [];
  // for Carousel Slider
  List<SliderModel> sliders = [];

  List<ArticleModel> article = [];

  bool isLoading = true;

  //!for DotIndi
  int activeIndex = 0;

  @override
  void initState() {
    categories = getCategories();
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    article = newsClass.news;

    setState(() {
      isLoading = false;
    });
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter ',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            Text(
              'News',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! Categories
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            image: categories[index].image,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),
                    // -----
                    const SizedBox(
                      height: 20,
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Breaking News!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "View all",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    //-----

                    const SizedBox(
                      height: 20,
                    ),

                    //! CarouselSlide
                    CarouselSlider.builder(
                      itemCount: 5,
                      itemBuilder: (context, index, realIndex) {
                        String? res = sliders[index].urlToImage;
                        String? res1 = sliders[index].title;
                        return buildImage(res!, index, res1!);
                      },
                      options: CarouselOptions(
                          height: 250,
                          //viewportFraction: 0.8,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index;
                            });
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: buidIndicator(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Trending News!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            
                            "View all",
                          
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //----

                    // InkWell(
                    //   onTap: () {},
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 10,
                    //     ),
                    //     child: Card(
                    //       elevation: 3,
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Container(
                    //             margin: const EdgeInsets.symmetric(
                    //               horizontal: 6,
                    //               vertical: 13,
                    //             ),
                    //             height: 100,
                    //             width: 100,
                    //             child: ClipRRect(
                    //               borderRadius: BorderRadius.circular(10),
                    //               child: Image.asset(
                    //                 "assets/images/b1.jpg",
                    //                 fit: BoxFit.cover,
                    //                 alignment: Alignment.center,
                    //               ),
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             width: 5,
                    //           ),
                    //           Column(
                    //             children: [
                    //               SizedBox(
                    //                 width:
                    //                     MediaQuery.of(context).size.width / 1.7,
                    //                 child: const Padding(
                    //                   padding: EdgeInsets.only(
                    //                     top: 6,
                    //                   ),
                    //                   child: Text(
                    //                     "This modification ensures that you do not go .",
                    //                     style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: 20,
                    //                       fontWeight: FontWeight.w300,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 height: 5,
                    //               ),
                    //               SizedBox(
                    //                 width:
                    //                     MediaQuery.of(context).size.width / 1.7,
                    //                 child: const Padding(
                    //                   padding: EdgeInsets.only(bottom: 4),
                    //                   child: Text(
                    //                     "Adjust the conditions as needed based on your specific requirements. This modification ensures that you do not go",
                    //                     // maxLines: 4,
                    //                     style: TextStyle(
                    //                         color: Colors.black38,
                    //                         fontSize: 20,
                    //                         fontWeight: FontWeight.w300),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(
                      height: 10,
                    ),

                    

                    SizedBox(
                     // margin: const EdgeInsets.only(bottom: 50),
                      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                      //color: Colors.red,
                      
                      child: ListView.builder(
                         physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: article.length,
                        itemBuilder: (context, index) {
                          return BlocTile(imageUrl: article[index].urlToImage!, title: article[index].title!, desc: article[index].description!);
                        },
                      ),
                    )

                    // InkWell(
                    //   onTap: () {

                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //       horizontal: 10,
                    //     ),
                    //     child: Card(
                    //       elevation: 3,
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: [
                    //           Container(
                    //             margin: const EdgeInsets.symmetric(
                    //               horizontal: 6,
                    //               vertical: 13,
                    //             ),
                    //             height: 100,
                    //             width: 100,
                    //             child: ClipRRect(
                    //               borderRadius: BorderRadius.circular(10),
                    //               child: Image.asset(
                    //                 "assets/images/b1.jpg",
                    //                 fit: BoxFit.cover,
                    //                 alignment: Alignment.center,
                    //               ),
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             width: 5,
                    //           ),
                    //           Column(
                    //             children: [
                    //               SizedBox(
                    //                 width: MediaQuery.of(context).size.width / 1.7,
                    //                 child: const Padding(
                    //                   padding: EdgeInsets.only(
                    //                     top: 6,
                    //                   ),
                    //                   child: Text(
                    //                     "This modification ensures that you do not go .",
                    //                     style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: 20,
                    //                       fontWeight: FontWeight.w300,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 height: 5,
                    //               ),
                    //               SizedBox(
                    //                 width: MediaQuery.of(context).size.width / 1.7,
                    //                 child: const Padding(
                    //                   padding: EdgeInsets.only(bottom: 4),
                    //                   child: Text(
                    //                     "Adjust the conditions as needed based on your specific requirements. This modification ensures that you do not go",
                    //                     // maxLines: 4,
                    //                     style: TextStyle(
                    //                         color: Colors.black38,
                    //                         fontSize: 20,
                    //                         fontWeight: FontWeight.w300),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }

  buildImage(String image, int index, String name) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: image,
              height: 250,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(top: 170),
            //color: Colors.black38,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buidIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: 5,
      effect: const ScaleEffect(
          activeDotColor: Colors.blue, dotHeight: 10, dotWidth: 10),
    );
  }
}

//! CATEGORY TILE
class CategoryTile extends StatelessWidget {
  final image, categoryName;

  const CategoryTile(
      {required this.image, required this.categoryName, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNews(titleName: categoryName)));
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: 10,
          top: 10,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                image,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Center(
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//! BLoc Tile
class BlocTile extends StatelessWidget {
  String imageUrl, title, desc;
  BlocTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Card(
          elevation: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 13,
                ),
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                     imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 6,
                      ),
                      child: Text(
                        title,
                        maxLines: 2,
                        style: const TextStyle(
                          
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        
                        desc,
                         maxLines: 4,
                        style: const TextStyle(
                            color: Colors.black38,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
