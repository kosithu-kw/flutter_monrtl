
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';


class Contact extends StatelessWidget {



  final String _subTitle="မြို့နယ်အတွင်းရှိ အရေးပေါ်ကယ်ဆယ်ရေးအဖွဲ့များ";
  final String _contact="ဆက်သွယ်ရန်";
  final data;

  const Contact({Key? key, required this.data}) : super(key: key);
  /*
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

   */



  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(data['name'],
          style: TextStyle(
              color: Colors.blueAccent
          ),
        ),

        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        centerTitle: true,

      ),
      body: Container(
        child: ListView(
          children: [
            if(data['phone']['one'] != null)
              Card(
                child: ListTile(
                  title: Text("ဆက်သွယ်ရန်"),
                  trailing: Icon(Icons.phone),
                  leading: Icon(Icons.contact_phone),
                  onTap: (){
                    launch(('tel://${data['phone']['one']}'));
                  },
                ),
              ),
            if(data['phone']['two'] != null)
              Card(
                child: ListTile(
                  title: Text("ဆက်သွယ်ရန်"),
                  trailing: Icon(Icons.phone),
                  leading: Icon(Icons.contact_phone),
                  onTap: (){
                    launch(('tel://${data['phone']['two']}'));
                  },
                ),
              ),
            if(data['phone']['three'] != null)
              Card(
                child: ListTile(
                  title: Text("ဆက်သွယ်ရန်"),
                  trailing: Icon(Icons.phone),
                  leading: Icon(Icons.contact_phone),
                  onTap: (){
                    launch(('tel://${data['phone']['three']}'));
                  },
                ),
              ),
            if(data['phone']['four'] != null)
              Card(
                child: ListTile(
                  title: Text("ဆက်သွယ်ရန်"),
                  trailing: Icon(Icons.phone),
                  leading: Icon(Icons.contact_phone),
                  onTap: (){
                    launch(('tel://${data['phone']['four']}'));
                  },
                ),
              ),
            if(data['phone']['five'] != null)
              Card(
                child: ListTile(
                  title: Text("ဆက်သွယ်ရန်"),
                  trailing: Icon(Icons.phone),
                  leading: Icon(Icons.contact_phone),
                  onTap: (){
                    launch(('tel://${data['phone']['five']}'));
                  },
                ),
              ),
            if(data['phone']['six'] != null)
              Card(
                child: ListTile(
                  title: Text("ဆက်သွယ်ရန်"),
                  trailing: Icon(Icons.phone),
                  leading: Icon(Icons.contact_phone),
                  onTap: (){
                    launch(('tel://${data['phone']['six']}'));
                  },
                ),
              ),
            if(data['phone']['seven'] != null)
              Card(
                child: ListTile(
                  title: Text("ဆက်သွယ်ရန်"),
                  trailing: Icon(Icons.phone),
                  leading: Icon(Icons.contact_phone),
                  onTap: (){
                    launch(('tel://${data['phone']['seven']}'));
                  },
                ),
              ),
            if(data['phone']['eight'] != null)
              Card(
                child: ListTile(
                  title: Text("ဆက်သွယ်ရန်"),
                  trailing: Icon(Icons.phone),
                  leading: Icon(Icons.contact_phone),
                  onTap: (){
                    launch(('tel://${data['phone']['eight']}'));
                  },
                ),
              )

          ],
        )
      ),
    );


  }
}

