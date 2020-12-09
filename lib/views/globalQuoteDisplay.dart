import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/models/globalQuoteModel.dart';
import 'package:news_app/services/globalQuoteService.dart';

class GlobalQuoteDisplay extends StatefulWidget {
  final String symbol;
  const GlobalQuoteDisplay(this.symbol);

  @override
  _GlobalQuoteDisplayState createState() => _GlobalQuoteDisplayState();
}

class _GlobalQuoteDisplayState extends State<GlobalQuoteDisplay> {

  Timer timer;
  final GlobalQuoteService globalQuoteService = GlobalQuoteService();
  final Duration duration = new Duration(seconds: 65);

  StreamController<GlobalQuoteModel> streamController = StreamController();

  void addToStream(GlobalQuoteModel value) {
    if (value != null) {
      streamController.add(value);
    }
  }

  @override
  void initState() {
      globalQuoteService.getGlobalQuote(widget.symbol).then(addToStream);
      timer = Timer.periodic(
        duration,
            (timer) {
          globalQuoteService.getGlobalQuote(widget.symbol).then(addToStream);
        },
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamController.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          var globalQuote = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Text(globalQuote.symbolName, style: TextStyle(color: Colors.black),),
                Spacer(flex: 1,),
                Text(globalQuote.price, style: TextStyle(color: Colors.black),),
                Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image(
                    height: 15,
                    fit: BoxFit.contain,
                    image: AssetImage("images/Up_arrow_icon_3x.png"),
                  ),
                ),
                Text(globalQuote.low, style: TextStyle(color: Colors.black),),
                Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Image(
                    height: 15,
                    fit: BoxFit.contain,
                    image: AssetImage("images/Down_arrow_icon_3x.png"),
                  ),
                ),
                Text(globalQuote.high, style: TextStyle(color: Colors.black),),
              ],

            ),
          );
        }
      },
    );
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
