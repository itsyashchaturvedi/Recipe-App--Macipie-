import 'dart:convert';
import 'package:http/http.dart';
import 'fetch_meal.dart';

class RandomDataModel{

  static Future<FetchMeal> randomFetch()async
  {

    Response response1=await get(Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php"));
    Map data=jsonDecode(response1.body);

    Map meal=data["meals"][0];
    return FetchMeal.fetching(meal as Map<String, dynamic> );
  }
}