import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

void main(){
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MainApp(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/home': (context) => HomeApp(),
      },
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MainApp> {

  final String _title="MON RTL";

  final String _mTitle="မွန်ပြည်နယ်";
  final String _subTitle="(၁၀) မြို့နယ်အတွင်းရှိ အရေးပေါ်ကယ်ဆယ်ရေးအဖွဲ့များ";

  bool _isConnection=false;


   checkConnection() async{
    var res=await http.get(Uri.https('raw.githubusercontent.com', "kosithu-kw/flutter_mrtl_data/master/townships.json"));
    if(res.statusCode==200){
     setState(() {
       Navigator.pushNamed(context, '/home');
     });



    }
    //print(res.statusCode);
  }

  @override
  void initState() {
    // TODO: implement initState
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_mTitle, style: TextStyle(color: Colors.blueAccent, fontSize: 30),),
                  Text(_subTitle),

                  SizedBox(height: 100,),
                  Container(
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
