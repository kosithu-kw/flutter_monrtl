
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:monrtl/main.dart';
import 'contact.dart';
import 'error.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class RTeams extends StatefulWidget {
  final data;

  const RTeams({Key? key, required this.data}) : super(key: key);

  @override
  _RTeamsState createState() => _RTeamsState();
}

class _RTeamsState extends State<RTeams> {





  final String _subTitle="မြို့နယ်အတွင်းရှိ အရေးပေါ်ကယ်ဆယ်ရေးအဖွဲ့များ";
  final String _contact="ဆက်သွယ်ရန်";


  getData() async{
    var url;
    var pUrl="https://raw.githubusercontent.com/kosithu-kw/flutter_mrtl_data/master/";
    if(widget.data['id']=="1"){
        url="${pUrl}mawlamyine.json";
    }else if(widget.data['id']=="2"){
      url="${pUrl}mudon.json";
    }else if(widget.data['id']=="3"){
      url="${pUrl}thanphyuzayat.json";
    }else if(widget.data['id']=="4"){
      url="${pUrl}kyaikhto.json";
    }else if(widget.data['id']=="5"){
      url="${pUrl}thaton.json";
    }else if(widget.data['id']=="6"){
      url="${pUrl}ye.json";
    }else if(widget.data['id']=="7"){
      url="${pUrl}paung.json";
    }else if(widget.data['id']=="8"){
      url="${pUrl}belin.json";
    }else if(widget.data['id']=="9"){
      url="${pUrl}chaungsone.json";
    }else{
      url="${pUrl}kyaikmayaw.json";
    }
    var result=await DefaultCacheManager().getSingleFile(url);
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


  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              _updateData();
            },
              icon: Icon(Icons.cloud_download),
            ),
          ],
          title: Text(widget.data['city_name'],
            style: TextStyle(
                color: Colors.blueAccent,

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
          backgroundColor: Colors.white,
          centerTitle: true,

        ),
      body: Container(
        child: FutureBuilder(
          future: _isUpdate ? getData() : getData(),
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
                      leading: Icon(Icons.contacts_sharp),

                      title: Text(
                          s.data[i]['name']
                      ),
                      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new Contact(data: s.data[i]))),
                      subtitle: Text(
                          _contact
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
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      );


  }
}

