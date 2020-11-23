import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/helper/article_fetch.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/views/article_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  String pickedCountry = "us";
  bool _loading = true;

  ///Scrollcontroller variables
  ScrollController _controller;
  String message = "";
  static int page = 0;
  bool isLoading = false;

  int pagination = 5;

  int refreshVariable = 0;

  int loadMore = 0;

  @override
  void initState() {
    // TODO: implement initState
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    categories = getCategories();
    getArticles();

    super.initState();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent - 10 &&
        !_controller.position.outOfRange) {
      setState(() {
        getArticles();
        message = "reach the bottom";
        // if(refreshVariable+5<articles.length){refreshVariable = refreshVariable + 5;}
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "reach the top";
        // if(refreshVariable-5<0){}else{refreshVariable = refreshVariable - 5;}
      });
    }
  }

  Future<void> getArticles() async {
    articles = await ArticleFetch().getTopHeadLines(pickedCountry);
    print('the are new articles');
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Map<int, Color> color = {
      50: Color.fromRGBO(4, 131, 184, .1),
      100: Color.fromRGBO(4, 131, 184, .2),
      200: Color.fromRGBO(4, 131, 184, .3),
      300: Color.fromRGBO(4, 131, 184, .4),
      400: Color.fromRGBO(4, 131, 184, .5),
      500: Color.fromRGBO(4, 131, 184, .6),
      600: Color.fromRGBO(4, 131, 184, .7),
      700: Color.fromRGBO(4, 131, 184, .8),
      800: Color.fromRGBO(4, 131, 184, .9),
      900: Color.fromRGBO(4, 131, 184, 1),
    };

    MaterialColor myColor = MaterialColor(0xff1B1B1B, color);
    //textStyle for title: robotoSlab
    return Material(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 300,
                child: DrawerHeader(
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage("images/drawer_gn_news_world_logo.png"),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_box_rounded),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
                title: Text('My profile'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(Icons.ad_units_outlined),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
                title: Text('My Notes'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(Icons.add_comment_outlined),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
                title: Text('Highlighted'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                leading: Icon(Icons.message_sharp),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
                title: Text('Messaging'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ), ListTile(
                leading: Icon(Icons.language_sharp),
                trailing: Icon(Icons.arrow_forward_ios_sharp),
                title: Text('Change country'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ///this will be a dialog box
              ListTile(
                title: Text('About us'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.add_alert),
              tooltip: 'Show Snackbar',
              onPressed: () {
              },
            ),
          ],
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Global",
                style: GoogleFonts.robotoSlab(color: Colors.white),
              ),
              Text(
                "News",
                style: TextStyle(color: MaterialColor(0xff70F6FF, color)),
              )
            ],
          ),
          elevation: 0.0,
        ),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    height: size.height * .20,
                    child: ListView.builder(
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,
                        );
                      },
                    ),
                  ),

                  ///ARTICLES
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      shrinkWrap: true,
                      // itemExtent: 100,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return NewsTile(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            description: articles[index].description,
                            url: articles[index].url);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.only(right: 10, top: 10),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: AssetImage("images/gn_no_news_image.png"),
                  image: NetworkImage(
                    imageUrl,
                  ),
                  width: size.width * 0.3,
                  height: size.height * 0.15,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.3,
                height: size.height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26,
                ),
                child: Text(
                  categoryName,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageUrl, title, description, url;

  NewsTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.description,
      @required this.url});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ArticleView(
            webUrl: url,
          );
        }));
      },
      child: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              child: FadeInImage(
                  fit: BoxFit.fitHeight,
                  placeholder: AssetImage("images/gn_no_news_image.png"),
                  image: NetworkImage(imageUrl)),
            ),
            // Image.asset("images/hivan_no_image.png"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(description, style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
