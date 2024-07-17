class FetchMeal{
  String img;
  String name;
  String instr;
  String youtube;
  String source;

  FetchMeal({
    required this.img,
    required this.name,
    required this.instr,
    required this.youtube,
    required this.source
  });

  static FetchMeal fetching(Map<String,dynamic>Meal)
  {
    return FetchMeal(
        img: Meal["strMealThumb"] ?? "https://cdn11.bigcommerce.com/s-11317/images/stencil/1280x1280/products/1126/4479/C36__71201.1267536962.jpg?c=2",
        name: Meal["strMeal"] ?? "This seems like data has been deleted.Sorry",
        instr: Meal["strInstructions"] ?? "Sorry for missing Instructions",
        source: Meal["strSource"] ?? "https://www.epicurious.com/search?q=${Meal["strMeal"]}",
        youtube:Meal["strYoutube"] ?? "https://www.youtube.com/results?search_query=${Meal["strMeal"]}",
    );
  }

}