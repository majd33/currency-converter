import 'package:flutter/material.dart';
import 'package:my_currency_converter/Api.dart';
import 'package:my_currency_converter/dropdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var mycontrol=TextEditingController();

  MyApi myApi=MyApi();


  List<String> currencies;
  String from , to;
  double rate;
  String result="";

  Future<List<String>> getCurrencyList() async{
    return await myApi.getCurr();
  }

  @override
  initState(){
    super.initState();
    (()async{
      List<String> list= await myApi.getCurr();
      setState((){
        currencies=list;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("Currency Converter"), backgroundColor: Colors.redAccent,),
        backgroundColor: Colors.grey[700],
      body:SafeArea(
    child: Padding(
    padding: EdgeInsets.symmetric(horizontal:16, vertical:18),
    child:
        /*currencies==null?Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Click in to load", style: TextStyle(color: Colors.redAccent),),
              SizedBox(height:10 ,),
              IconButton(icon: Icon(Icons.loop), color: Colors.white,iconSize: 50, onPressed: ()async{
                List<String> list= await myApi.getCurr();
                setState((){
                  currencies=list;
                });
              }),
            ],
          ),
        ):*/
    Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Expanded(child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    TextField(decoration: InputDecoration(filled: true, fillColor: Colors.white, labelText: "Input value to convert"),
    keyboardType: TextInputType.number,
   style: TextStyle(
     color: Colors.black,
   ),
    controller: mycontrol,
    /*onSubmitted:
    (value)async{
    rate=await myApi.getRate(from, to);
    setState(() {
    result=(rate* double.parse(value)).toStringAsFixed(3);
    });
    },*/
    ),
      SizedBox(height: 15,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListDown(currencies,from,(val){setState(() {from=val;});}),
          FloatingActionButton(onPressed:(){String temp=from; setState((){from=to; to=temp;});}, child:Icon(Icons.swap_horiz), elevation:0.0, backgroundColor : Colors.redAccent),
          ListDown(currencies,to,(val){setState(() {to=val;});}),
        ],
      ),
      SizedBox(height: 50,),
      Container(
        width: double.infinity,
        child: FlatButton(
          onPressed: ()async{
                var value=mycontrol.text;
              rate=await myApi.getRate(from, to);
              setState(() {
                result=(rate* double.parse(value)).toStringAsFixed(3);
              });

          },
          child: Text("Convert"),
          color: Colors.redAccent,
          textColor: Colors.white,
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),),
      ),
      SizedBox(height: 50,),
      Container(
        width: double.infinity,
        padding :EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(children: [
          Text("result", style: TextStyle(color: Colors.redAccent, fontSize: 24,),),
          Text("$result", style: TextStyle(color: Colors.black, fontSize: 36,fontWeight: FontWeight.bold)),
        ],),
      ),
    ],
    ),
    ),
    ),
    ],
    ),
    )));
  }
}
