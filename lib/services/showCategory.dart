import 'dart:convert';



import 'package:http/http.dart' as http;



import '../models/showCategory_model.dart';

class ShowCategoryNews{
  List<ShowCategoryModel> categories=[];
  
  
  Future<void> getCategoryNews(String category)async{
String url="https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=9fedc0a18c4246eaad74add98c56f3ef";
 var response= await http.get(Uri.parse(url));

var jsonData= jsonDecode(response.body);
print(jsonData);

if(jsonData['status']=='ok'){
  jsonData["articles"].forEach((element){
    if(element["urlToImage"]!=null && element['description']!=null){
      ShowCategoryModel showCategoryModel= ShowCategoryModel(
        title: element["title"],
        description: element["description"],
        url: element["url"],
        urlToImage: element["urlToImage"],
        content: element["content"],
        author: element["author"],
      );
      categories.add(showCategoryModel);
    }
  });
}
 
  }
}
