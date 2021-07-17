
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'error.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:share/share.dart';


import 'RTeams.dart';

void main()=>runApp(HomeApp());



class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<HomeApp> {


  _getData() async{

    var result=await DefaultCacheManager().getSingleFile("https://raw.githubusercontent.com/kosithu-kw/flutter_mrtl_data/master/townships.json");
    var file=await result.readAsString();
    var jsonData=jsonDecode(file);
    return jsonData;


  }

  bool _isUpdate=false;

  _updateData() async{
   await DefaultCacheManager().emptyCache().then((value){
     setState(() {
       _isUpdate=true;

     });
     Timer(Duration(seconds: 5), () {
       setState(() {
          _isUpdate=false;
       });
     });
   });
  }

  @override
  void initState() {
    // TODO: implement initState
      //DefaultCacheManager().emptyCache();
    super.initState();
  }

  final String _title="မွန်ပြည်နယ်";
  final String _subTitle="(၁၀) မြို့နယ်အတွင်းရှိ အရေးပေါ်ကယ်ဆယ်ရေးအဖွဲ့များ";
  final String _bSubtitle="မြို့နယ်အတွင်းရှိ အရေးပေါ်ကယ်ဆယ်ရေးအဖွဲ့များ";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(fontFamily: 'uni'),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
                _updateData();
            },
                icon: Icon(Icons.cloud_download),
            ),
          ],
          title: Text(_title,
            style: TextStyle(
                color: Colors.blueAccent

            ),
          ),
          bottom: PreferredSize(
            child: Text(_subTitle,
                style: TextStyle(
                    color: Colors.black,
                  height: 3.0
                )),
            preferredSize: Size.fromHeight(30),

          ),
          iconTheme: IconThemeData(
              color: Colors.black
          ),
          centerTitle: true,
          backgroundColor: Colors.white,

        ),
        drawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: Text("App Version"),
                  subtitle: Text("1.0.0"),
                  leading: Icon(Icons.settings_accessibility),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new HomeApp()));
                  },
                ),
                ListTile(
                  title: Text("Share App"),
                  leading: Icon(Icons.share),
                  onTap: (){
                    Share.share("https://play.google.com/store/apps/details?id=com.goldenmawlamyine.monrtl");
                  },
                ),
              ],
            ),
        ),
        body: Container(
          child: FutureBuilder(
            future: _isUpdate ? _getData() : _getData(),
            builder: (context, AsyncSnapshot s){
              if(_isUpdate)
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 120, right: 120),
                        child: LinearProgressIndicator(),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Updating data from server..."),
                      )
                    ],
                  ),
                );
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
                    child: IconButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => new ErrorApp()));
                      },
                      icon: Icon(Icons.refresh_outlined),
                      color: Colors.blueAccent,
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
