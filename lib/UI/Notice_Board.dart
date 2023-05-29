import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_aap/utils.dart';
class NoticeBoard extends StatefulWidget {
  const NoticeBoard({Key? key}) : super(key: key);

  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  var notice_Data ;



  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: FutureBuilder<dynamic>(
        future:  NoticeFetchFun(),
        builder:  (context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(notice_Data,style: const TextStyle(),));
            }else{
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
    }

      ),
    );
  }

  NoticeFetchFun() async {
    final headers = {'Content-Type':'application/json'};
    var res = await http.get(
      Uri.parse('http://$ip/user/notice'),
      headers: headers,
    );
     var notice   = json.decode(res.body);
    notice_Data = notice[0]["all_notice"];
        return notice;
  }
}
