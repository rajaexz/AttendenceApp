import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_aap/UI/Setting.dart';
import '../main.dart';
import '../utils.dart';

import 'package:http/http.dart' as http;
class changePass extends StatefulWidget {
  var ID;
  var Name;
  var email;

  changePass({Key? key,  this.ID, this.Name, this.email}) : super(key: key);
  @override
  State<changePass> createState() => _changePassState();
}

class _changePassState extends State<changePass> {

  final _storage = const FlutterSecureStorage();
  String _password = '';
  String _confirmPassword = '';

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(

                decoration: const BoxDecoration(color: Color(0xff1e6eee)),
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push( context, MaterialPageRoute( builder: (BuildContext context) => Setting(ID:widget.ID,Name: widget.Name,email:widget.email) ));
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
                      'Change Password',
                      style: header,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Form(
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
                     TextButton(onPressed: (){
                       // validate all forms fields
                       if (_formKey.currentState!.validate()) {
                         changePassInData();
                       }
                     }, child: Text('Change'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> changePassInData() async {
    // ignore: non_constant_identifier_names
    print(widget.ID);
    Map<String, dynamic> jsonMap = {
      "userId": widget.ID,
      "conpass": _confirmPassword
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
                'Your Password Has Been Successfully Update !')),
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
}
