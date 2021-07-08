
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:monrtl/main.dart';
import 'contact.dart';
import 'error.dart';


class RTeams extends StatelessWidget {



  final String _subTitle="မြို့နယ်အတွင်းရှိ အရေးပေါ်ကယ်ဆယ်ရေးအဖွဲ့များ";
  final String _contact="ဆက်သွယ်ရန်";
  final data;

  const RTeams({Key? key, required this.data}) : super(key: key);

  getData() async{
    var url;
    var pUrl="kosithu-kw/flutter_mrtl_data/master/";
    if(this.data['id']=="1"){
        url="${pUrl}mawlamyine.json";
    }else if(this.data['id']=="2"){
      url="${pUrl}mudon.json";
    }else if(this.data['id']=="3"){
      url="${pUrl}thanphyuzayat.json";
    }else if(this.data['id']=="4"){
      url="${pUrl}kyaikhto.json";
    }else if(this.data['id']=="5"){
      url="${pUrl}thaton.json";
    }else if(this.data['id']=="6"){
      url="${pUrl}ye.json";
    }else if(this.data['id']=="7"){
      url="${pUrl}paung.json";
    }else if(this.data['id']=="8"){
      url="${pUrl}belin.json";
    }else if(this.data['id']=="9"){
      url="${pUrl}chaungsone.json";
    }else{
      url="${pUrl}kyaikmayaw.json";
    }
    var res=await http.get(Uri.https('raw.githubusercontent.com', url));
    var jsonData=jsonDecode(res.body);
    return jsonData;
  }

  void _showModal(){

  }

  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text(data['city_name'],
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
          future: getData(),
          builder: (context, AsyncSnapshot s){
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

