import 'dart:convert';
import 'package:http/http.dart' as http;

class MyApi{
  //final Uri apiUrl = Uri.https("https://free.currconv.com", "/api/v7/", {"apiKey":"7caadf28e3da82cd5ed2"});

  var apiUrl= Uri.parse("https://free.currconv.com/api/v7/currencies?apiKey=c86f2b26da757907279d");
  Future<List<String>> getCurr() async{
    http.Response res= await http.get(apiUrl);
    if(res.statusCode==200){
      var body=jsonDecode(res.body);
      var list = body["results"];
      List<String> curr= (list.keys).toList();
      print(curr);

      return curr;
    }
    else{
      //throw Exception("failed");
      print("faild");
    }
  }


  Future getRate(String from, String to) async {
    var apiUrl= Uri.parse("https://free.currconv.com/api/v7/convert?q=${from}_${to}&compact=ultra&apiKey=c86f2b26da757907279d");
    //final Uri rateUrl = Uri.https("free.currconv.com", "/api/v7/convert", {"apiKey":"4f6ef6f6c136f9f2e860", "q":"${from}_${to}", "compact": "ultra"});
    http.Response res= await http.get(apiUrl);
    if(res.statusCode==200){
      var body=jsonDecode(res.body);
      return body["${from}_${to}"];
    }else{
      //throw Exception("failed");
      print("failed");
    }

  }
}