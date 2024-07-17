import 'dart:convert';
import 'package:foodapp/fetch_meal.dart';
import 'package:foodapp/item_list.dart';
import 'package:http/http.dart';

class MenuDataModel{

  static Future<FetchMeal> fetchData(String fine,int i)async
  {

    List<String> menuItem= await ItemList.fetching(fine);
    Response response=await get(Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=${menuItem[i]}"));
    Map data=jsonDecode(response.body);
    Map meal=data["meals"][0];
    return FetchMeal.fetching(meal as Map<String, dynamic> );

  }
}