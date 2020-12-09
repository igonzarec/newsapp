import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/article_fetch.dart';
import 'package:news_app/views/home.dart';
import 'globals.dart' as globals;


class CategoryNews extends StatefulWidget {
  final String category;

  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArticlesByCategory();
  }

  Future<void> getArticlesByCategory() async {
    articles = await FetchByCategory()
        .getTopHeadLinesByCategory(country: globals.language, category: widget.category);
    print('the are new articles by category');
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

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
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
              AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.grey[800],
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.category[0].toUpperCase()}${widget.category.substring(1)}",
                      style: GoogleFonts.robotoSlab(color: Colors.white),
                    )
                  ],
                ),
                elevation: 0.0,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _controller,
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
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

}
