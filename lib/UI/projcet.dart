import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_aap/UI/profile.dart';

import '../utils.dart';

class ProjectList extends StatefulWidget {
  static String id = "ProjectsPage";

  var Id;
  var Name;
  var email;
  ProjectList({super.key, this.Id, this.Name, this.email});

  @override
  State<ProjectList> createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  var data1;
  var name;
  var project;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: projectList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            data1 = snapshot.data;
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Stack(
     
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xff1e6eee),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProfileInfo(
                                              sendDataId: widget.Id,
                                              DbuserName: widget.Name,
                                              EmailName: widget.email)));
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                      
                          Text(
                            'Projects',
                            style: header,
                          ),
                     
                
                            Container(
                        width: 40,
                        child:Text(""),
                      ),
                        ],
                      ),
                    ),
                   
                   Container(
                         margin: const EdgeInsets.only(top: 70),
                     child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                       return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Card(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  
                  children: [
                         Container(
                      margin:
                          const EdgeInsets.only(top: 0, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              child: const Text(
                                "Project Name",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                  data1[index]["project_name"].toString(),
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 0, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              child: const Text(
                                "Start date",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                  data1[index]["project_start_date"].toString(),
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 0, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              child: const Text(
                                "End date",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                  data1[index]["project_end_date"].toString(),
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 0, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              child: const Text(
                                "Status",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(
                                  data1[index]["status"].toString() == "1"
                                      ? "Open"
                                      : "Close",
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
               
                  ],
                ),
              )
            ],
          );
        
        }),
                   )
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            ));
          }
        });
  }

   projectList() async {
    final headers = {'Content-Type': 'application/json'};
    final encoding = Encoding.getByName('utf-8');
    Map<String, String> jsonMap1 = {
      'id': widget.Id,
    };
    String body1 = json.encode(jsonMap1); // encode map to json
    var res = await http.post(
      Uri.parse('http://$ip/user/project'),
      body: body1,
      headers: headers,
      encoding: encoding,
    );

    var data = json.decode(res.body);

    return data;
  }


}
