import 'package:bagzz/constant/constant.dart';
import 'package:bagzz/models/bags_gridview_item.dart';
import 'package:bagzz/models/bags__image_slides.dart';
import 'package:bagzz/models/category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> likedBagsItemIds = [];
  //init controller
  final PageController controller =
      PageController(initialPage: 0, keepPage: true);

//override dispose class to also dispose the conroller to avoid memory leakage
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderImageSlider(context, controller),
          GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: bags_gridview_item.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, i) {
                return bagGridView(
                    bags_gridview_item[i].image, bags_gridview_item[i].name);
              }),
          gridView(),
          gridText(),
          gridviewCategory(),
          gridBrowse(),
        ],
      ),
    );
  }

//Widget for Image Slider on the Home Page Header
  Widget HeaderImageSlider(BuildContext context, PageController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 28, horizontal: 11),
      height: 205,
      width: 714,
      child: Stack(
        fit: StackFit.loose,
        children: [
          PageView.builder(
              controller: controller,
              itemCount: bags.length,
              itemBuilder: (context, i) {
                return imageSlide(bags[i].image, bags[i].title);
              }),
          Positioned(
            top: 154,
            right: 10,
            child: Row(children: [
              Container(
                height: 51,
                color: colorBlack,
                width: 51,
                child: IconButton(
                  color: colorWhite,
                  onPressed: () {
                    controller.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  icon: Icon(Icons.arrow_back),
                  iconSize: 26,
                ),
              ),
              SizedBox(
                width: 1,
              ),
              Container(
                height: 51,
                color: colorBlack,
                width: 51,
                child: IconButton(
                  color: colorWhite,
                  onPressed: () {
                    controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  icon: Icon(Icons.arrow_forward),
                  iconSize: 26,
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

//Widget Design for Image Slider
  Widget imageSlide(String image, String title) {
    return Stack(
      children: [
        Container(
          color: Colors.grey[100],
          height: 195,
          width: 714,
          child: Image(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 70,
          right: 13,
          child: Container(
            height: 84,
            width: 92,
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Playfair',
                background: new Paint()
                  ..color = Colors.white
                  ..strokeWidth = 30
                  ..style = PaintingStyle.stroke,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

//Widget Gridview for lists of bags
  Widget bagGridView(String image, String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 11, right: 15, bottom: 11),
      child: Container(
        height: 210,
        width: 170,
        color: Color(0XFFF1F1F1),
        child: Stack(
          children: [
            Positioned(
                top: 6,
                right: 9,
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.black,
                  size: 18,
                )),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image(image: AssetImage(image)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontFamily: playFair,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'SHOP NOW',
                        style: TextStyle(
                            fontFamily: workSans,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 88,
                    color: Colors.black,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget gridView() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.black,
            )),
            child: Text("CHECK ALL LATEST",
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ))),
      ),
    );
  }

  Widget gridText() {
    return Container(
        padding: EdgeInsets.only(left: 11.0, top: 40.0),
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 10.0),
        child: Text("Shop By Categories",
            style: TextStyle(
              fontFamily: playFair,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            )));
  }

  Widget gridCategoryItems(int id, String image, String categoryTitle) {
    return Container(
      padding: const EdgeInsets.only(left: 11, right: 15, bottom: 11),
      height: 224,
      width: 170,
      child: Stack(
        children: [
          Image(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: 11,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: colorBlack,
                child: Text(
                  categoryTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorWhite,
                    fontFamily: playFair,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget gridviewCategory() {
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: bags_gridview_item.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: .8,
        ),
        itemBuilder: (context, i) {
          return gridCategoryItems(
            categlist[i].id,
            categlist[i].image,
            categlist[i].categoryTitle,
          );
        });
  }

  Widget gridBrowse() {
    return Center(
      child: Container(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.black,
            )),
            child: Text("BROWSE ALL CATEGORIES",
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ))),
      ),
    );
  }
}
