import 'dart:isolate';


import 'package:flutter/material.dart';

var value=0;
class homepage extends StatelessWidget {
   homepage({super.key});
  final receiverport=ReceivePort();




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Center(
        child:Column(
          children: [
            Image.asset('asset/gifs/giphy.gif'),
            ElevatedButton(onPressed:(){
              fun1();
              setstate();

            }, child:const Text("Task1")),
            const SizedBox(height:20,),

            ElevatedButton(
                onPressed:(){
                  isolatefun();
                },
                child:Text("Passing Argument")),

            ElevatedButton(onPressed:()=>{
                Isolate.spawn(complexTask,receiverport.sendPort),

            }, child:const Text("Without Passing arugment")),
            const SizedBox(height: 20,),
            Text('${value}'),

          ],
        ),
      )
    );
  }

  void setstate() {}
}


isolatefun(){
  final receiverport=ReceivePort();

  try{
    Isolate.spawn(runtask,[receiverport.sendPort,10000]);
  } on Object{
        print("failed");
        receiverport.close();
  }

  final res=receiverport.first;
  print("this is massge passing${res}");

}


int runtask(List<dynamic>args){
    SendPort result=args[0];
    for(var i=0;i<args[1];i++){
      value+=i;
    }

    Isolate.exit(result,value);

}

Future<void>fun1()async {

  for(var i=0;i<100000000;i++){
    value+=i;
  }
  print(value);
  return ;
}


Future<void> complexTask(SendPort sendPort)async {

  for(var i=0;i<100000;i++){
    value+=i;
  }
  print(value);

}



