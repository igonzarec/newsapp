import 'package:news_app/models/category_model.dart';
import 'package:easy_localization/easy_localization.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> categories = new List<CategoryModel>();

  CategoryModel category = new CategoryModel();
  //1
  category.categoryName = "business".tr();
  category.imageUrl = "https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80";
  categories.add(category);

  category = new CategoryModel();
  //2
  category.categoryName = "entertainment".tr();
  category.imageUrl = "https://images.unsplash.com/photo-1481328101413-1eef25cc76c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80";
  categories.add(category);

  category = new CategoryModel();
  //3
  category.categoryName = "general".tr();
  category.imageUrl = "https://images.unsplash.com/photo-1456121566917-718f3af0df86?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1351&q=80";
  categories.add(category);

  category = new CategoryModel();
  //4
  category.categoryName = "health".tr();
  category.imageUrl = "https://images.unsplash.com/photo-1483721310020-03333e577078?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2000&q=80";
  categories.add(category);

  category = new CategoryModel();
  //5
  category.categoryName = "science".tr();
  category.imageUrl = "https://images.unsplash.com/photo-1567427018141-0584cfcbf1b8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80";
  categories.add(category);

  category = new CategoryModel();
  //6
  category.categoryName = "sports".tr();
  category.imageUrl = "https://images.unsplash.com/photo-1519861531473-9200262188bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1051&q=80";
  categories.add(category);

  category = new CategoryModel();
  //7
  category.categoryName = "technology".tr();
  category.imageUrl = "https://images.unsplash.com/photo-1531297484001-80022131f5a1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1307&q=80";
  categories.add(category);

  return categories;
}