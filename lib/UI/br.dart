import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_aap/utils.dart';
  br() async {
    final headers = {'Content-Type':'application/json'};
    var res = await http.get(
      Uri.parse('http://$ip/user/birthday'),
      headers: headers,
    );
    var notice   = json.decode(res.body);
      print("BR ======================== $notice");
     return notice;

  }