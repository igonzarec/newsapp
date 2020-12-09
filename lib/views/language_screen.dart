import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:news_app/views/home.dart';
import 'globals.dart' as globals;

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "settings".tr(),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    child: ListTile(
                      leading: Icon(Icons.language, color: Colors.white,),
                      title: Text("switch_language".tr(), style: TextStyle(color: Colors.white),),
                      trailing: Icon(Icons.update, color: Colors.white,),
                    ),
                  ),
                  onTap: (){

                    if (context.locale == Locale('de', 'DE')) {
                      setState(() {
                        context.locale = Locale('en', 'US');
                        globals.language = "us";
                      });
                    } else if (context.locale == Locale('en', 'US')) {
                      setState(() {
                        context.locale = Locale('de', 'DE');
                        globals.language = "de";
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.grey[900],
    );
  }
}