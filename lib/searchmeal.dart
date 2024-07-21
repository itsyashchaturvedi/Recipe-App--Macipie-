import 'package:flutter/material.dart';
import 'package:foodapp/webview.dart';

class SearchMeal extends StatefulWidget {
String img;
String name;
String instr;
String youtube;
String source;

  SearchMeal({super.key,
    required this.img,
    required this.name,
    required this.instr,
    required this.youtube,
    required this.source});

  @override
  State<SearchMeal> createState() => _SearchMealState();
}

class _SearchMealState extends State<SearchMeal> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 340,
              child: FadeInImage.assetNetwork
                (fit: BoxFit.fill,
                  fadeInDuration: const Duration(milliseconds: 1150),
                  placeholder: "assets/loading.gif",
                  image:widget.img,
                placeholderFit:BoxFit.none,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
              child: Text(widget.name,style:const TextStyle(fontSize: 25,fontFamily: 'Roboto',fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
            ),
            Padding(padding: const EdgeInsets.fromLTRB(8, 0, 8, 15),
              child: Text(widget.instr,style:const TextStyle(fontSize: 15,color: Colors.black45),),),
            Row(
              children: [
                InkWell(
                  onTap: ()
                  {
                    if(widget.youtube=="") {
                      widget.youtube="https://www.youtube.com/results?search_query=${widget.name}";
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> WebView(linkUrl: widget.youtube,)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0, 10),
                    child:  Image.asset('assets/Youtube.gif',height: 60.0, width: 80,fit: BoxFit.cover,),
                  ),
                ),
                const Expanded(child: const SizedBox()),
                InkWell(
                  onTap: ()
                  {
                      if(widget.source=="") {
                        widget.source="https://www.epicurious.com/search?q=${widget.name}";
                      }
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                WebView(linkUrl: widget.source.toString()
                                    .replaceAll("http:", "https:"),)));
                      },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(90, 5.0, 0, 10),
                    child: Image.asset('assets/more-info.gif',height: 60.0,width: 100,fit: BoxFit.cover,),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
