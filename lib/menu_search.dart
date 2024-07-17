import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:foodapp/item_list.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/fetch_meal.dart';
import 'package:foodapp/searchmeal.dart';
import 'menudata_model.dart';

class MenuSearch extends StatefulWidget {
  final String name;
  const MenuSearch({super.key, required this.name});

  @override
  State<MenuSearch> createState() => _MenuSearchState();
}

class _MenuSearchState extends State<MenuSearch> {
  late FetchMeal fetchMeal;
  int currentPageIndex = 0;
  bool isLoading = true;
  bool isCountLoading=true;
  int counted=0;
  late List <String> count;
  Future<void> getName()async {
    count = await ItemList.fetching(widget.name);
    setState(() {
      isCountLoading=false;
      getCounted();
    });
  }
  void getCounted(){
    if(isCountLoading){
      const Center(child: CircularProgressIndicator(),);
    }
    else
      {
        counted=count.length;
      }
  }
  @override
  void initState() {
    super.initState();
    getName();
    getData(currentPageIndex);
  }
  Future<void> getData(int index) async {
      fetchMeal = await MenuDataModel.fetchData(widget.name, index);
      setState(() {
        isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: PageView.builder(
          itemCount: counted,
          onPageChanged: (value) {
            setState(() {
              currentPageIndex = value;
              getData(currentPageIndex);
            });
          },
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {

            if (isLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent,));
            }
            else {
              return SearchMeal(
                img: fetchMeal.img,
                name: fetchMeal.name,
                instr: fetchMeal.instr,
                youtube: fetchMeal.youtube,
                source: fetchMeal.source,
              );
            }

          },
        ),
      );
    }
}