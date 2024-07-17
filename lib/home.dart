import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:foodapp/menu_search.dart';
import 'package:foodapp/randomdata_model.dart';
import 'package:foodapp/searchdata_model.dart';
import 'package:foodapp/fetch_meal.dart';
import 'package:foodapp/item_list.dart';
import 'package:foodapp/searchmeal.dart';
import 'package:foodapp/webview.dart';



class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FetchMeal fetchMeal1;
  late FetchMeal fetchMeal2;
  late FetchMeal fetchMeal3;
  late FetchMeal fetchMeal4;
  late FetchMeal fullFetchMeal;
  bool isChecked1=true;
  bool isChecked2=true;
  bool isChecked3=true;
  bool isChecked4=true;
  bool isChecked5=true;
  Future<void> getData5()async{
    fullFetchMeal=await RandomDataModel.randomFetch();
    setState(() {
      isChecked5=false;
    });
  }
  Future<void> getData1()async{
    fetchMeal1=await RandomDataModel.randomFetch();
    setState(() {
      isChecked1=false;
    });
  }
  Future<void> getData2()async{
    fetchMeal2=await RandomDataModel.randomFetch();
    setState(() {
      isChecked2=false;
    });
  }
  Future<void> getData3()async{
    fetchMeal3=await RandomDataModel.randomFetch();
    setState(() {
      isChecked3=false;
    });
  }
  Future<void> getData4()async{
    fetchMeal4=await RandomDataModel.randomFetch();
    setState(() {
      isChecked4=false;
    });
  }
  Random random= Random();
  late String foodImages;
  bool doneImage=true;
  Future<void> getImage()async{
    foodImages= ItemList.foodImages[random.nextInt(ItemList.foodImages.length)];
    setState(() {
      doneImage=false;
    });
  }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getImage();
    getData1();
    getData2();
    getData3();
    getData4();
    getData5();
  }
  @override
  Widget build(BuildContext context) {
    FetchMeal fetchMeal;


    bool isLoading=true;
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: Colors.white,
        title:const Padding(padding: EdgeInsets.fromLTRB(70, 0, 0, 0),child:Text("Macipie",style: TextStyle(fontFamily: 'MeaCulpa',fontWeight: FontWeight.bold,fontSize: 33 ),)),
        iconTheme:const IconThemeData(),
        leading: PopupMenuButton(
          popUpAnimationStyle:AnimationStyle(curve: Curves.linear,duration: const Duration(milliseconds: 850)),
          shadowColor: Colors.blue,
          surfaceTintColor: Colors.blueAccent,
          onSelected: (value) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> MenuSearch(name: value.toString())));
            },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(value: "American",child: Text("American",style: TextStyle(fontSize: 17.0),),),
            const PopupMenuItem(value: "Chinese",child: Text("Chinese",style: TextStyle(fontSize: 17.0),)),
            const PopupMenuItem(value: "Indian",child: Text("Indian",style: TextStyle(fontSize: 17.0),)),
            const PopupMenuItem(value: "Egyptian",child: Text("Egyptian",style: TextStyle(fontSize: 17.0),)),
            const PopupMenuItem(value: "Canadian",child: Text("Canadian",style: TextStyle(fontSize: 17.0),)),
            const PopupMenuItem(value: "Tunisian",child: Text("Tunisian",style: TextStyle(fontSize: 17.0),)),
            const PopupMenuItem(value: "Japanese",child: Text("Japanese",style: TextStyle(fontSize: 17.0),)),
          ],
          child: const Icon(Icons.menu,color: Colors.indigo,),
        ),
      ),
      body: isChecked1||isChecked2||isChecked3||isChecked4||isChecked5||doneImage?const Center(child: CircularProgressIndicator(color: Colors.indigo,),)
          :SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: TypeAheadField<String>(
                suggestionsCallback: (search) {
                  return ItemList.food.where((meal) => meal.toLowerCase().contains(search.toLowerCase())).toList();
                },
                builder: (context, controller, focusNode) {
                  return TextField(
                      autofocus:false,
                        controller: controller,
                        focusNode: focusNode,
                         cursorColor: Colors.indigo,
                         decoration:  InputDecoration(
                           hintText: "Search...",
                           suffixIcon: const Icon(Icons.search_rounded),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(25.0),
                           ),
                         ),
                    );
                },
                itemBuilder: (context, meal) {
                  return ListTile(
                    title: Text(meal),
                  );
                },
                onSelected: (meal) async{
                  fetchMeal= await DataModel.getdata(meal);
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>SearchMeal(img: fetchMeal.img, name: fetchMeal.name, instr: fetchMeal.instr,youtube: fetchMeal.youtube,source: fetchMeal.source,
                  ))) ;
                },
              )
            ),
            const SizedBox(
              height: 13,
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                height: 220,
                width: MediaQuery.of(context).size.width-20,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child:FadeInImage.assetNetwork(image:foodImages,
                  fit: BoxFit.fill, placeholder: 'assets/loading.gif',placeholderFit: BoxFit.none,),

                )
              ),
            ),
            const Padding(
              padding:  EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
              child:  SizedBox(
                child: Text("Popular",style:TextStyle(fontFamily: 'Vidaloka',fontSize: 25,
                color: Colors.indigo),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height:150,
                width: MediaQuery.of(context).size.width,
                child:  SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:  Row(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(borderRadius:BorderRadius.circular(25.0),
                              child: FadeInImage.assetNetwork(width:180,fit:BoxFit.fill,image: fetchMeal1.img,placeholderFit: BoxFit.none,placeholder: 'assets/spinner.gif',)),
                          InkWell(onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchMeal(img: fetchMeal1.img, name: fetchMeal1.name, instr: fetchMeal1.instr, youtube: fetchMeal1.youtube, source: fetchMeal1.source)));},
                                   child: Container(width:180,decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.circular(25.0)),)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Align(alignment:Alignment.bottomLeft,child: Text(fetchMeal1.name.length>13?fetchMeal1.name.substring(0,14):fetchMeal1.name,style: const TextStyle(fontSize: 20,fontFamily: 'Vidaloka',color: Colors.white),)),
                          )
                      ]),
                      const SizedBox(width: 12,),
                      Stack(
                          children: [
                            ClipRRect(borderRadius:BorderRadius.circular(25.0),
                                child: FadeInImage.assetNetwork(width:180,fit:BoxFit.fill,image: fetchMeal2.img,placeholderFit: BoxFit.none,placeholder: 'assets/spinner.gif',)),
                            InkWell(onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchMeal(img: fetchMeal2.img, name: fetchMeal2.name, instr: fetchMeal2.instr, youtube: fetchMeal2.youtube, source: fetchMeal2.source)));},
                                child: Container(width:180,decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.circular(25.0)),)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Align(alignment:Alignment.bottomLeft,child: Text(fetchMeal2.name.length>13?fetchMeal2.name.substring(0,14):fetchMeal2.name,style: const TextStyle(fontSize: 20,fontFamily: 'Vidaloka',color: Colors.white),)),
                            )
                          ]),
                      const SizedBox(width: 12,),
                      Stack(
                          children: [
                            ClipRRect(borderRadius:BorderRadius.circular(25.0),
                                child: FadeInImage.assetNetwork(width:180,fit:BoxFit.fill,image: fetchMeal3.img,placeholderFit: BoxFit.none, placeholder: 'assets/spinner.gif',)),
                            InkWell(onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchMeal(img: fetchMeal3.img, name: fetchMeal3.name, instr: fetchMeal3.instr, youtube: fetchMeal3.youtube, source: fetchMeal3.source)));},
                                child: Container(width:180,decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.circular(25.0)),)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Align(alignment:Alignment.bottomLeft,child: Text(fetchMeal3.name.length>13?fetchMeal3.name.substring(0,14):fetchMeal3.name,style: const TextStyle(fontSize: 20,fontFamily: 'Vidaloka',color: Colors.white),)),
                            )
                          ]),
                      const SizedBox(width: 12,),
                      Stack(
                          children: [
                            ClipRRect(borderRadius:BorderRadius.circular(25.0),
                                child: FadeInImage.assetNetwork(width:180,fit:BoxFit.fill,image: fetchMeal4.img,placeholderFit: BoxFit.none, placeholder: 'assets/spinner.gif',)),
                            InkWell(onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchMeal(img: fetchMeal4.img, name: fetchMeal4.name, instr: fetchMeal4.instr, youtube: fetchMeal4.youtube, source: fetchMeal4.source)));},
                                child: Container(width:180,decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.circular(25.0)),)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Align(alignment:Alignment.bottomLeft,child: Text(fetchMeal4.name.length>13?fetchMeal4.name.substring(0,14):fetchMeal4.name,style: const TextStyle(fontSize: 20,fontFamily: 'Vidaloka',color: Colors.white),)),
                            )
                          ]),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding:  EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
              child:  SizedBox(
                child: Text("Recommended",style:TextStyle(fontFamily: 'Vidaloka',fontSize: 25,
                    color: Colors.indigo),),
              ),
            ),
                  Center(child: ClipRRect(borderRadius:BorderRadius.circular(25.0),
                      child: FadeInImage.assetNetwork(height: 250,fit:BoxFit.fill,alignment:Alignment.center,width:MediaQuery.of(context).size.width-20,
                        image: fullFetchMeal.img,
                        placeholderFit: BoxFit.none,
                        placeholder: 'assets/loading.gif',))),
         Padding(
           padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
            child:
              Padding(
                padding: const EdgeInsets.fromLTRB(5,0, 5, 0),
                  child: Text(fullFetchMeal.name,style:const TextStyle(fontSize: 25,fontFamily: 'Roboto',fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
        ),
      ),
           Padding(padding: const EdgeInsets.fromLTRB(8, 0, 8, 15),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
               child: Text(fullFetchMeal.instr,style:const TextStyle(fontSize: 15,color: Colors.black45),),
        ),),
            Row(
             children: [
               InkWell(
                  onTap: ()
                  {
                  if(fullFetchMeal.youtube=="") {
                  fullFetchMeal.youtube="https://www.epicurious.com/search?q=${fullFetchMeal.name}";
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> WebView(linkUrl: fullFetchMeal.youtube,)));
                 },
                 child: Padding(
                 padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0, 10),
                   child:  Image.asset('assets/Youtube.gif',height: 60.0, width: 80,fit: BoxFit.cover,),
            ),
          ),
             const Expanded(child: SizedBox()),
              InkWell(
            onTap: ()
            {
              if(fullFetchMeal.source=="") {
                fullFetchMeal.source="https://www.epicurious.com/search?q=${fullFetchMeal.name}";
              }
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                      WebView(linkUrl: fullFetchMeal.source.toString()
                          .replaceAll("http:", "https:"),)));
            },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(90, 5.0, 0, 10),
                   child: Image.asset('assets/more-info.gif',height: 60.0,width: 100,fit: BoxFit.cover,),
            ),
          ),
          ],
        ),
     ] ),
      ));
  }
}


