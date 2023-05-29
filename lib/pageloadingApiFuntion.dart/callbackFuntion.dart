import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_aap/utils.dart';

  Future<dynamic> callAsyncFetch(sendDataId) =>
      Future.delayed(const Duration(seconds: 1), () async {
        
        Map<String, String> jsonMap = {'userId': "$sendDataId"};
        final headers = {'Content-Type': 'application/json'};
        String Body1 = json.encode(jsonMap); // encode map to json
        final encoding = Encoding.getByName('utf-8');
        var res = await http.post(
          Uri.parse('http://$ip/user/login/2'),
          body: Body1,
          headers: headers,
          encoding: encoding,
        );

        var jsonData = json.decode(res.body);

        return jsonData;
      });
         

     var dateTime  = DateTime.now();

lateChcek() =>
      Future.delayed(const Duration(seconds: 0), () async {
   final headers = {'Content-Type': 'application/json'};
    var res = await http.get(
      Uri.parse('http://$ip/user/lateChcek'),
      headers: headers,
    );
        var jsonData = json.decode(res.body);
         
        return jsonData[0]["office_Time"];
      });




