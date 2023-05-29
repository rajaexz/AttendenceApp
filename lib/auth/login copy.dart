import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_aap/UI/br.dart';
import 'package:steel_crypt/steel_crypt.dart';

import '../UI/profile.dart';

import '../utils.dart';

class Login extends StatefulWidget {
  static String id = "LoginPage";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //send to next screen
  var sendDataId;
  var DbuserName;
  var EmailName;

  final _storage = const FlutterSecureStorage();
  //All Request Data
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

//sigUp post data
  Future<dynamic> attemptLogin() async {
    final name = _usernameController.text;
    final password = _passwordController.text;
    var hasspassword = " ";
    hasspassword = password.toString();
//encrypt using GCM
    var hasher = HashCrypt(algo: HashAlgo.Sha_256);

    var hash = hasher.hash(inp: hasspassword);

    Map<String, String> jsonMap = {'name': name, 'password': hash};
    final headers = {'Content-Type': 'application/json'};
    String body = json.encode(jsonMap); // encode map to json
    final encoding = Encoding.getByName('utf-8');

    var res = await http.post(
      Uri.parse('http://$ip/user/login'),
      body: body,
      headers: headers,
      encoding: encoding,
    );

    if (!res.body.contains('USERNOT')) {
      var data = jsonDecode(res.body);
      sendDataId = data[0]['id'] ?? " ";
      DbuserName = data[0]['user_name'] ?? " ";
      EmailName = data[0]['email_id'] ?? " ";
      // logs_login();
    } else {}
    return jsonDecode(res.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

// Show error massage function
  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xff1e6eee),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 90,
                        bottom: 530,
                        child: Align(
                          child: SizedBox(
                            width: 224 * fem,
                            height: 138 * fem,
                            child: Image.asset(
                              'assets/page-1/images/dn.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // vector4UmS (64:7)
                        left: 0 * fem,
                        top: 340 * fem,
                        child: Align(
                          child: Container(
                            width: 390 * fem,
                            height: MediaQuery.of(context).size.height / 1.5,
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 100,
                                left: 0,
                                right: 0),
                            child: Image.asset(
                                'assets/page-1/images/vector-5.png',
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Positioned(
                        // login2kL (65:32)
                        left: 45 * fem,
                        top: 515 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 300 * fem,
                            height: 100 * fem,
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                  border: null,
                                  labelText: 'User Email',
                                  labelStyle: SafeGoogleFont(
                                    'Poppins',
                                    height: 1.5 * ffem / fem,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some Name';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 45 * fem,
                        top: 590 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 300 * fem,
                            height: 100 * fem,
                            child: TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  border: null,
                                  labelText: 'Password',
                                  labelStyle: SafeGoogleFont(
                                    'Poppins',
                                    height: 1.5 * ffem / fem,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some Password';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // loginYkc (65:33)
                        left: 45 * fem,
                        top: 440 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 95 * fem,
                            height: 53 * fem,
                            child: Text(
                              'Login',
                              style: SafeGoogleFont(
                                'Poppins',
                                fontSize: 35 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.5 * ffem / fem,
                                color: Color(0xff1e6eee),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // rectangle6Qnp (65:35)
                        left: 150 * fem,
                        top: 680 * fem,
                        child: Align(
                          child: ElevatedButton(
                            onPressed: OnChange,
                            child: const Text('LETS GO'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> OnChange() async {
    var username = _usernameController.text;
    var password = _passwordController.text;
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      if (username.length < 4) {
        displayDialog(context, "Invalid Username",
            "The username should be at least 4 characters long");
      } else if (password.length < 4) {
        displayDialog(context, "Invalid Password",
            "The password should be at least 4 characters long");
      } else {
        // This is the featch routes
        // displayDialog(context, "",
        //     " YOU GRT RESPONSE ");
        var ResponseData = await attemptLogin();

        var pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);

        if (ResponseData == 'USERNOT') {
          if (!regex.hasMatch(username)) {
            // ignore: use_build_context_synchronously
            displayDialog(context, "Warning", "Invalid User Email !!! ");
          } else {
            // ignore: use_build_context_synchronously
            displayDialog(
                context, "unauthorized User", "Invalid  password !!! ");
          }
        } else {
          _storage.write(key: 'userId', value: "$sendDataId");
          _storage.write(key: 'userName', value: '$DbuserName');
          _storage.write(key: 'email', value: '$EmailName');
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileInfo(
                      sendDataId: sendDataId,
                      DbuserName: DbuserName,
                      EmailName: EmailName)));
        }
      }
    }
  }
}
