import 'dart:convert';
import 'package:foodapp/fetch_meal.dart';
import 'package:http/http.dart';

class DataModel{

  static Future<FetchMeal> getdata(String fine)async
  {

      Response response=await get(Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?s=$fine"));
      Map data=jsonDecode(response.body);

      Map meal=data["meals"][0];
      return FetchMeal.fetching(meal as Map<String, dynamic> );
  }
}