import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../utils.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //All Request Data
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

//sigUp post data
  Future attemptSignUp() async {
    final name = _usernameController.text;
    final password = _passwordController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    
    Map<String, String> jsonMap = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password
    };

    final headers = {'Content-Type': 'application/json'};
    String Body1 = json.encode(jsonMap); // encode map to json
    final encoding = Encoding.getByName('utf-8');

    var res = await http.post(
      Uri.parse('http://$ip/user/signup'),
      body: Body1,
      headers: headers,
      encoding: encoding,
    );

    return res.body;
  }

// Show error massage function
  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),

      );
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some Name';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Email ',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some Email';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Phone',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Phone',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some Phone';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Password',
                          style: TextStyle(fontSize: 20),
                        )),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some Password';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //forgot password screen
                      },
                      child: const Text(
                        'Forgot Password',
                      ),
                    ),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child:  Text('Sign in'),
                          onPressed: OnChange,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Does not have account?'),
                        TextButton(
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            //signup screen
                          },
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ));
  }

  Future<void> OnChange() async {
    var username = _usernameController.text;
    var password = _passwordController.text;
    var email = _emailController.text;
    var phone = _phoneController.text;
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    // Validate returns true if the form is valid, or false otherwise.
  


    if (_formKey.currentState!.validate()) {
      if (username.length < 4) {
        // ignore: use_build_context_synchronously
        displayDialog(context, "Invalid Username",
            "The username should be at least 4 characters long");
      } else if (password.length < 4) {
        // ignore: use_build_context_synchronously
        displayDialog(context, "Invalid Password",
            "The password should be at least 4 characters long");
      } else if (phone.length != 10) {
        // ignore: use_build_context_synchronously
        displayDialog(context, "Invalid Number",
            "The password should be at least 10 characters long");
      } else if (!regex.hasMatch(email)) {
        // ignore: use_build_context_synchronously
        displayDialog(context, "Invalid Email", "The Email ");
      } else {
  var res = await attemptSignUp();
     var decode = jsonDecode(res);
     
        if(decode == "susses"){
         _usernameController.text =" ";
       _passwordController.text="";
         _emailController.text ="";
        _phoneController.text="";
         // ignore: use_build_context_synchronously
         displayDialog(context, "ok", "ok");


      } else if(decode == "duplicate"){
         // ignore: use_build_context_synchronously
         displayDialog(context, "Email duplicate", "Email duplicate ");
      }
      }
    }
  }
}
