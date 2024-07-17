import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.asset("assets/logo.png"
                  ,height: 200,width: 200,alignment: Alignment.center,),
              ),
              const Text("Macipie",style: TextStyle(fontFamily: 'Pacifio',fontWeight: FontWeight.w200,fontSize: 37,),),
              const SizedBox(
                height: 2,
              ),
              const Spacer(),
              const Text("@Developed by Yash Chaturvedi",style: TextStyle(color: Colors.black38,fontSize: 13.4,),),
              const SizedBox(
                height: 12.5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
