
class GlobalQuoteModel {
  GlobalQuoteModel({
    this.symbolName,
    this.high,
    this.low,
    this.price,
  });

  String symbolName;
  String high;
  String low;
  String price;

  factory GlobalQuoteModel.fromJson(Map<String, dynamic> json) => GlobalQuoteModel(
    symbolName: json["01. symbol"],
    high: json["03. high"],
    low: json["04. low"],
    price: json["05. price"],
  );

  factory GlobalQuoteModel.fromListJson(Map<String, dynamic> json) => GlobalQuoteModel(
    symbolName: json["1. symbol"]
  );

  Map<String, dynamic> toJson() => {
    "01. symbol": symbolName,
    "03. high": high,
    "04. low": low,
    "05. price": price,
  };
}
