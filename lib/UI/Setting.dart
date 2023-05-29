import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_aap/UI/profile.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:my_aap/main.dart';
import 'package:steel_crypt/steel_crypt.dart';


import '../utils.dart';
DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
class Setting extends StatefulWidget {
  var ID;
  var Name;
  var email;

   Setting({Key? key,  this.ID, this.Name, this.email}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  var sendDataId ;
  final _storage = const FlutterSecureStorage();
  String _password = '';
  String _confirmPassword = '';

  final _formKey = GlobalKey<FormState>();

  final deviceInfoPlugin = DeviceInfoPlugin();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Color(0xff1e6eee)),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
    
                child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push( context, MaterialPageRoute( builder: (BuildContext context) => ProfileInfo(sendDataId:widget.ID,DbuserName: widget.Name,EmailName:widget.email) ));
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
    
                    const SizedBox(
                      width: 10,
                    ),
                     Text(
                      'Setting ',
                      style: header,
                    ),
    
                    Container(
                      child: TextButton(
                        onPressed: (){
                          logs_login();
                          Navigator.of(context).pushAndRemoveUntil(
                            // the new route
                            MaterialPageRoute(
                              builder: (BuildContext context) => Home(),
                            ),
    
                                (Route route) => false,
                          );
    
                          _storage.delete(key: 'userName');
                          _storage.delete(key: 'email');
                          _storage.delete(key: 'userId');
                        },
                        child: Container(
    
                          child:  Icon(Icons.logout,size: 30,color:  Colors.white,),
                        ),
                      )
                    ),
                  ],
                ),
              ),
    
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 20, right: 20),
                child:
              Column(
                children: [
    
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
    
    
    
                        TextFormField(
                            decoration: const InputDecoration(
                              hintText: "Password",
                            ),
                            onChanged: (value){
                              _password = value;
                            },
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Password is required please enter';
                              }
                              // you can check password length and specifications
                              return null;
                            }
                        ),
    
    
                        const SizedBox(
                          height: 30,
                        ),
    
                        TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Confirm Password",
                            ),
                            onChanged: (value){
                              _confirmPassword = value;
                            },
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Conform password is required please enter';
                              }
                              if(value != _password){
                                return 'Confirm password not matching';
                              }
                              return null;
                            }
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(onPressed: (){
                          // validate all forms fields
                          if (_formKey.currentState!.validate()) {
                            changePassInData();
                          }
                        }, child: Text('Change'))
                      ],
                    ),
                  ),
    
    
    
                ],
              ),)
            ],
          ),
        ),
      )),
    );
  }
  Future<dynamic> changePassInData() async {

   var hasspassword = " ";
    hasspassword = _confirmPassword.toString();


var hasher = HashCrypt(algo: HashAlgo.Sha_256);

 var hash = hasher.hash(inp: hasspassword);
 
    Map<String, dynamic> jsonMap = {
      "userId": widget.ID,
      "conpass": hash
    };
    final headers = {'Content-Type': 'application/json'};
    String Body1 = json.encode(jsonMap); // encode map to json
    final encoding = Encoding.getByName('utf-8');
    var res = await http.post(
      Uri.parse('http://$ip/user/changepass'),
      body: Body1,
      headers: headers,
      encoding: encoding,
    );
    if( res.statusCode == 200){
      showDialog(
        context: context,
        builder: (context) =>
        const AlertDialog(
            title: Text(
                'successful '),
            content: Text(
                'Your Password Has Been Successfull Update !')),
      );
      await Future.delayed(const Duration(milliseconds: 1500),()=>  Navigator.of(context).pushAndRemoveUntil(
        // the new route
        MaterialPageRoute(
          builder: (BuildContext context) => Home(),
        ),
            (Route route) => false,
      ) );
      _storage.delete(key: 'userName');
      _storage.delete(key: 'email');
      _storage.delete(key: 'userId');
    }else{
      print("some thing is wrong ");
    }
  }

  logs_login()async{
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

    //  login logs
    final headers = {'Content-Type': 'application/json'};
    final encoding = Encoding.getByName('utf-8');
    Map<String, String> jsonMap1 = {'email':widget.email, 'deviceName': '${androidInfo.brand!= null ?androidInfo.brand :iosInfo.name}'};
    String body1 = json.encode(jsonMap1); // encode map to json
    var res1 = await http.post(
      Uri.parse('http://$ip/user/login_info'),
      body: body1,
      headers: headers,
      encoding: encoding,
    );
  
  }

}
