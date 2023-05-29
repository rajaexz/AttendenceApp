import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_aap/UI/profile.dart';
import '../utils.dart';
class LeaveShow extends StatefulWidget {
  static String id = "LeaveShowPage";
  var ID;
  var Name;
  var email;
  LeaveShow({Key? key, this.ID, this.Name, this.email}) : super(key: key);

  @override
  State<LeaveShow> createState() => _LeaveShowState();
}

int indexAll = 0;

class _LeaveShowState extends State<LeaveShow> {
  var LeaveType;
  var LeaveTypeTotalDays;

  var md;
  var mdDay;
  var pr;
  var prDay;

  var cl;
  var clday;
  var sendDataId;

  var leavesData;
  var leaveDesc;
  var LDData;
  var stIcon;


  var leavefrom;

  var allindex = 0;
  var LT;
  var TotalCount;
  var TT;
  var LC;
  var LCA;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    Future.delayed(Duration.zero, () {
      setState(() {
        leavesData = ModalRoute.of(context)?.settings.arguments;
        // leave_typeApi(leavesData);
        print(leavesData);
        leaveType(leavesData);
      });
    });
  }
// remove this api fetch
  callAsyncFetch() async {
    Map<String, String> jsonMap = {'userId': "$sendDataId"};
    final headers = {'Content-Type': 'application/json'};
    String Body = json.encode(jsonMap); // encode map to json
    final encoding = Encoding.getByName('utf-8');
    var res = await http.post(
      Uri.parse('http://$ip/user/leave2'),
      body: Body,
      headers: headers,
      encoding: encoding,
    );
    var jsonData = json.decode(res.body);
    leaveDesc = json.decode(res.body);
    return jsonData;
  }


  String _leave_from(dynamic from){

    return from['leave_from'];
  }
  String _leave_to(dynamic to){
    return to['leave_to'];
  }
  String trans_time (dynamic trans){
    return trans['trans_time'];
  }

  String leave_category(dynamic leave){
    return leave['leave_category'];
  }

  String leave_comment(dynamic comment){
    return comment['leave_comment'];
  }
  String day(dynamic comment){
    return comment['days'].toString();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    final args = ModalRoute.of(context)!.settings.arguments as LeaveShow;
    sendDataId = args.ID;
    //Icon filter
    filterIcon(LDData) {
      if (LDData == "Medical Leave") {
        return const Icon(Icons.medical_services_rounded, color: Colors.grey);
      } else if (LDData == "Casual Leave") {
        return const Icon(Icons.cabin_outlined, color: Colors.grey);
      } else if (LDData == "Personal Leave") {
        return const Icon(
          Icons.person,
          color: Colors.grey,
        );
      }
      return const Icon(Icons.ac_unit_outlined);
    };


    return FutureBuilder<dynamic>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: <Widget>[
                  Container(
                    height: 130,
                    decoration: const BoxDecoration(
                        color: SecondaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0))),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30.0))),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProfileInfo(
                                                  sendDataId: args.ID,
                                                  DbuserName: args.Name,
                                                  EmailName: args.email)));
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
                                  const Text(
                                    'Leave List',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "poppins"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  
                  
                  header(),
                  //list container
                  Container(
                    margin: const EdgeInsets.only(top: 170),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        // LT = leaveDesc != null
                        //     ? leaveDesc[index]['leave_type'].toString()
                        //     : "empty";
                        // LF = leaveDesc != null
                        //     ? leaveDesc[index]['leave_from'].toString()
                        //     : "empty";
                        // LTo = leaveDesc != null
                        //     ? leaveDesc[index]['leave_to'].toString()
                        //     : "empty";
                        // TT = leaveDesc != null
                        //     ? leaveDesc[index]['trans_time'].toString()
                        //     : "empty";

                        // LC = leaveDesc != null
                        //     ? leaveDesc[index]['leave_category'].toString()
                        //     : "empty";
                        // LCA = leaveDesc != null
                        //     ? leaveDesc[index]['leave_comment'].toString()
                        //     : "empty";

                        LDData = leaveDesc[index]['leave_desc'].toString();
                        stIcon = filterIcon(leaveDesc[index]['leave_desc'].toString());

                        // //Date Count Function
                        // DurationCount(start, end) {
                        //   if (leave_category(snapshot.data[index]) == "Half Day") {
                        //     return 0.5;
                        //   } else {
                        //     start = start != null
                        //         ? DateTime(start.year, start.month, start.day)
                        //         : DateTime.now();
                        //     end = end != null
                        //         ? DateTime(end.year, end.month, end.day)
                        //         : DateTime.now();
                        //     return (end.difference(start).inHours / 24);
                        //   }
                        // }
                        // TotalCount = DurationCount(DateTime.parse(_leave_from(snapshot.data[index])), DateTime.parse(_leave_to(snapshot.data[index])));

                        //Date Date former Function
                        Dateformete(mydate){
                          final moonLanding = DateTime.parse(mydate);
                          switch(moonLanding.month) {
                            case 1: {
                              var date= moonLanding.day;
                              List<String> dateArray = [date.toString(),"Jan"];
                              return dateArray;
                            }
                            break;

                            case 2: {
                              var date= moonLanding.day;
                              List<String>  dateArray = [date.toString(),"Feb"];
                              return dateArray;
                            }
                            break;
                            case 3: {
                              var date= moonLanding.day;
                              List<String>  dateArray = [date.toString(),"March"];
                              return dateArray;
                            }
                            break;
                            case 4: {
                              //statements;


                              var date= moonLanding.day;
                              List<String>  dateArray = [date.toString(),"Apr"];
                              return dateArray;
                            }
                            break;
                            case 5: {
                              var date= moonLanding.day;
                              List<String>  dateArray = [date.toString(),"May"];
                              return dateArray;
                            }
                            break;
                            case 6: {
                              var date= moonLanding.day;
                              List<String>  dateArray = [date.toString(),"Jun"];
                              return dateArray;
                            }
                            break;

                            case 7: {

                              var date= moonLanding.day;
                              List<String>  dateArray = [date.toString(),"Jul"];
                              return dateArray;
                            }
                            break;
                            case 8: {

                              var date= moonLanding.day;
                              List<String>  dateArray = [date.toString(),"Aug"];
                              return dateArray;
                            }
                            break;

                            case 9: {

                              var date= moonLanding.day;
                              List<String>  dateArray = [date.toString(),"Sep"];
                              return dateArray;
                            }
                            break;
                            case 10: {
                              var date= moonLanding.day;
                              List<String>  dateArray = [date.toString(),"Oct"];
                              return dateArray;
                            }
                            break;
                            case 11: {

                              var date= moonLanding.day;
                              List<String>  dateArray = [date.toString(),"Nov"];
                              return dateArray;
                            }
                            break;
                            case 12: {
                              var date= moonLanding.day;
                              List<String>  dateArray = [date.toString(),"Dec"];
                              return dateArray;
                            }
                            break;
                            default: {
                              List<String>  dateArray = ["Error"];
                              return dateArray;

                            }
                            break;
                          }

                        }
                        List<String> ourMount= Dateformete(_leave_from(snapshot.data[index]));

                        return Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 0,
                              right: 10,
                              left: 20,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Date Calender Icon
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                            const EdgeInsets.only(top: 20),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(
                                                    5.0,
                                                    5.0,
                                                  ),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 2.0,
                                                ), //BoxShadow
                                                BoxShadow(
                                                  color: Colors.white,
                                                  offset: Offset(0.0, 0.0),
                                                  blurRadius: 0.0,
                                                  spreadRadius: 0.0,
                                                ),
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                            ),
                                            height: 60,
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 57,
                                                  alignment: Alignment.center,
                                                  decoration: const BoxDecoration(
                                                      color: Color(0xff1e6eee),
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(
                                                              5.0),
                                                          topRight: Radius
                                                              .circular(
                                                              5.0))),
                                                  child:  Text(ourMount[1].toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8.0),
                                                  child: Text(ourMount[0].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                    //All list view
                                    Expanded(
                                      flex: 5,
                                      child: Column(

                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 20, left: 20, bottom: 10),
                                            child: Row(


                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      alignment: Alignment.topLeft,

                                                      width: width / 7,
                                                      child: stIcon),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Text(
                                                          LDData.toString(),
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                    )),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 0, left: 20, bottom: 10),

                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    margin: const EdgeInsets.only(
                                                        right: 10),
                                                    child: const Text(
                                                      "Duration",
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Text(
                                                          day(snapshot.data[index])+" Day",
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                    )),
                                              ],
                                            ),
                                          ),

                                          // Date
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 0, left: 20, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    width: width / 7,
                                                    child: const Text(
                                                      "Date",
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Text(  "${_leave_from(snapshot.data[index])} : ${_leave_to(snapshot.data[index])}",
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        
                                        
                                        
                                        
                                          // Date
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 0, left: 20, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    width: width / 7,
                                                    child: const Text(
                                                      "Type",
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(leave_category(snapshot.data[index]),
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .black54,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold))),
                                              ],
                                            ),
                                          ),

                                          // type
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 0, left: 20, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    width: width / 7,
                                                    child: const Text(
                                                      "Notes",
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      child: Text(
                                                          leave_comment(snapshot.data[index]),
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          const Divider(height: 20,color: Colors.grey,)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.data == null) {
            return header();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            );
          }
        });
  }
  Widget header (){
    return Container(
      height: 60,
      width: 400,
      margin: const EdgeInsets.only(top: 90, left: 10, right: 10),
      decoration: const BoxDecoration(
          color: Colors.white60,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${mdDay??0}/${md ?? 0}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto Mono sample",
                        color: Colors.grey[600]),
                  ),
                  const Text("MEDICAL LEAVE",
                      style: TextStyle(
                          fontSize: 12, fontFamily: "poppins")),
                ],
              )),
          Container(width: 1, color: Colors.grey),
          Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${clday ?? 0}/${cl?? 0}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto Mono sample",
                        color: Colors.grey[600]),
                  ),
                  const Text("CASUAL LEAVE",
                      style: TextStyle(
                          fontSize: 12, fontFamily: "poppins")),
                ],
              )),
          Container(width: 1, color: Colors.grey),
          Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${ prDay ?? 0}/${pr??0}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto Mono sample",
                        color: Colors.grey[600]),
                  ),
                  const Text("PERSONAL LEAVE",
                      style: TextStyle(
                          fontSize: 12, fontFamily: "poppins")),
                ],
              )),
        ],
      ),
    );
  }
  leaveType(leavesData) async {

    var Myemail = leavesData.email;
    Map<String, String> jsonMap = {'email': "$Myemail"};
    final headers = {'Content-Type': 'application/json'};
    String Body = json.encode(jsonMap); // encode map to json
    final encoding = Encoding.getByName('utf-8');
    var res = await http.post(
      Uri.parse('http://$ip/user/findType'),
      body: Body,
      headers: headers,
      encoding: encoding,
    );


    //////////////////////////////find issue leave type//////////////////////////////////////////
    var res1 = await http.get(
      Uri.parse('http://$ip/user/findType1'),
      headers: headers,
    );


    var jsonData  = json.decode(res.body);
   //findType data
    LeaveType = json.decode(res.body);

    //findType1 data
    LeaveTypeTotalDays = json.decode(res1.body);

    var ttl_leave;
    var days ;
setState(() {
  cl =  LeaveTypeTotalDays[1]['days'];
  md = LeaveTypeTotalDays[2]['days'];
  pr = LeaveTypeTotalDays[3]['days'];
});


    for(int i =0 ; i < LeaveType.length ; i++){
    if(LeaveType[i]["leave_type"] == "Medical Leave" ){
      ttl_leave=   LeaveType[i]["ttl_leave"].toString();
      days = LeaveType[i]["days"].toString();

      mdDay = days.toString();


    }else if(LeaveType[i]["leave_type"] == "Personal Leave"){
      ttl_leave=   LeaveType[i]["ttl_leave"];
      days = LeaveType[i]["days"] ;

      prDay = days.toString();


    }else if(LeaveType[i]["leave_type"] == "Casual Leave"){
      ttl_leave=   LeaveType[i]["ttl_leave"].toString();
      days = LeaveType[i]["days"].toString() ;
      clday = days.toString();
    }

    }



    return jsonData;
  }
}


