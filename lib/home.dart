
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

import 'RTeams.dart';

void main()=>runApp(HomeApp());




class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<HomeApp> {

  getData() async{
    var res=await http.get(Uri.https('raw.githubusercontent.com', "kosithu-kw/flutter_mrtl_data/master/townships.json"));
    var jsonData=jsonDecode(res.body);
    return jsonData;
  }

  final String _title="မွန်ပြည်နယ်";
  final String _subTitle="(၁၀) မြို့နယ်အတွင်းရှိ အရေးပေါ်ကယ်ဆယ်ရေးအဖွဲ့များ";
  final String _bSubtitle="မြို့နယ်အတွင်းရှိ အရေးပေါ်ကယ်ဆယ်ရေးအဖွဲ့များ";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(

          title: Text(_title,
            style: TextStyle(
                color: Colors.blueAccent

            ),
          ),
          bottom: PreferredSize(
            child: Text(_subTitle,
                style: TextStyle(
                    color: Colors.black
                )),
            preferredSize: Size.fromHeight(20),
          ),
          iconTheme: IconThemeData(
              color: Colors.black
          ),
          centerTitle: true,
          backgroundColor: Colors.white,

        ),
        drawer: Drawer(

        ),
        body: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot s){
              if(s.hasData){

                return ListView.builder(
                  itemCount: s.data.length,
                  itemBuilder: (context, i){
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("images/${s.data[i]['image']}"), // no matter how big it is, it won't overflow
                        ),
                        trailing: Icon(
                            Icons.navigate_next

                        ),
                        title: Text(
                            s.data[i]['city_name']
                        ),
                        onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new RTeams(data: s.data[i]))),
                        subtitle: Text(
                            _bSubtitle
                        ),
                      ),
                    );
                  },

                );

              }else if(s.hasError) {
                return Center(
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => new MainApp()));
                      },
                      child: Text("အင်တာနက်ဆက်သွယ်မှုများကိုစစ်ဆေးပြီးပြန်လည်ကြိုးစားကြည့်ပါ",
                        style: TextStyle(color: Colors.orange),
                      ),
                    )
                );
                // return Center(
                //  child: CircularProgressIndicator(),
                //);
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );

  }
}
