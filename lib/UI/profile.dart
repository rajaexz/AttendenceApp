import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import 'package:my_aap/UI/projcet.dart';
import '../UI/Setting.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_aap/UI/LevesData.dart';
import '../adminPage/NewPage.dart';
import '../pageloadingApiFuntion.dart/callbackFuntion.dart';
import '../utils.dart';
import 'Notice_Board.dart';
import 'holidayList.dart';
import 'leavesPage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import './projcet.dart';
//notification

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//image picker


var _image;


const appHeight = 650.0;
const appWidth = 350.0;
const topSectionHeight = 250.0;
const middleSectionHeight = 110.0;
const PrimaryColor = Color(0xffb3e1fd);
const SecondaryColor = Color(0xff1e6eee);

class ProfileInfo extends StatefulWidget {
  static String id = "ProfilePage";
  var sendDataId;
  var DbuserName;
  var EmailName;
  var Attandence;
  ProfileInfo(
      {this.sendDataId,
      this.DbuserName,
      this.EmailName,
      this.Attandence,
      super.key});
  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;



  Future initializetimezone() async {
    tz.initializeTimeZones();
  }

  String? _networkStatusMsg;
  final Connectivity _internetConnectivity = Connectivity();
  var sendDataId;
  var DbuserName;
  var EmailName;
  var allLeaveData1;
  var projcetCount;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    sendDataId = widget.sendDataId;
    DbuserName = widget.DbuserName;
    EmailName = widget.EmailName;
     projectList();
    LeaveFetchFun();
    _checkNetworkStatus();
    logs_login();
    



    //notification
    var initializationSettingsAndroid = const AndroidInitializationSettings(
        '@drawable/res_notification_app_icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: callAsyncFetch(sendDataId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 299,
                      decoration: const BoxDecoration(
                          color: SecondaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0))),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30.0))),
                      child: Center(
                          child: Column(children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff022711).withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () async {
                              
                              },
                             
                              child: Stack(
                                children: const [
                                 CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 55.0,
                                        backgroundImage:  AssetImage('assets/page-1/images/avatar.png') ,
                                    )
                                         
                                ],
                              ),
                            )),
                        Text(DbuserName,
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontFamily: 'poppins')),
                        Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: Text(EmailName,
                                style: const TextStyle(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'poppins'))),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                          
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, LeaveShow.id,
                                        arguments: LeaveShow(
                                            ID: "$sendDataId",
                                            Name: DbuserName,
                                            email: EmailName));
                                  },
                                  child: Column(
                                    children: [
                                            Text(
                                  allLeaveData1.toString() == "null"? "0" :   allLeaveData1.toString() ,
                                  style: buildMontserrat(
                                    Colors.white,
                                  ),
                                ),
                                      Text(
                                        "LEAVE",
                                        style: buildMontserrat(Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                            const SizedBox(
                              height: 50,
                              child: VerticalDivider(
                                color: Colors.white,
                              ),
                            ),
                            
                          
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.length.toString(),
                                    style: buildMontserrat(
                                      Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "ATTENDANCE",
                                    style: buildMontserrat(
                                      Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),


                             const SizedBox(
                              height:50,
                              child: VerticalDivider(
                                color: Colors.white,
                              ),
                            ),
                                
                                
                                 Expanded(
                              child: Column(
                                children: [
                                  
                                GestureDetector(
                                  onTap:() {
                              
                                               Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ProjectList(
                                                  Id: "$sendDataId",
                                                  Name: DbuserName,
                                                  email: EmailName)));
                                  },
                                  child: Column(
                                    children: [
                                            Text(
                                 projcetCount.toString() == "null"? "0": projcetCount.toString(),
                                  style: buildMontserrat(
                                    Colors.white,
                                  ),
                                ),
                                      Text(
                                        "PROJECTS",
                                        style: buildMontserrat(Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                                ],
                              ),
                            ),
                          
                          ],
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Leaves.id,
                                      arguments: Leaves(
                                          ID: "$sendDataId",
                                          Name: DbuserName,
                                          email: EmailName));
                                },
                                child: Card(
                                  child: Container(
                                    height: 150,
                                    width: 160,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.person_off_outlined,
                                          size: 50,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "APPLY LEAVE",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              OnlineJsonData(
                                                  ID: "$sendDataId",
                                                  Name: DbuserName,
                                                  email: EmailName)));
                                },
                                child: Card(
                                  child: Container(
                                    height: 150,
                                    width: 160,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.calendar_month,
                                          size: 50,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "ATTENDANCE",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Holiday(
                                          ID: sendDataId,
                                          Name: DbuserName,
                                          email: EmailName,
                                        ),
                                      ));
                                },
                                child: Card(
                                  child: Container(
                                    height: 150,
                                    width: 160,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.weekend_outlined,
                                          size: 50,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          " HOLIDAY  LIST",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                               
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Setting(
                                                  ID: "$sendDataId",
                                                  Name: DbuserName,
                                                  email: EmailName)));
                                },
                                child: Card(
                                  child: Container(
                                    height: 150,
                                    width: 160,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.settings,
                                          size: 50,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "SETTINGS",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.all(2),
                                child: Container(
                                  height: 150,
                                  width: 345,
                                  padding: EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(70.0))),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const <Widget>[
                                      Text(
                                        "NOTICE BOARD",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      NoticeBoard()
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ])),
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


  void _checkNetworkStatus() {
    _internetConnectivity.onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        _networkStatusMsg = result.toString();


        print("$_networkStatusMsg");
        if (_networkStatusMsg != "ConnectivityResult.mobile") {
          // _networkStatusMsg = "Please connected to mobile network";
        } else {
          // _networkStatusMsg = "Internet connection may not be available. Connect to another network";
          // displayDialog(context ,_networkStatusMsg," Connect to another network ");
        }     
      });
    });

     
  }

  logs_login() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //  login logs
    final headers = {'Content-Type': 'application/json'};
    final encoding = Encoding.getByName('utf-8');
    Map<String, String> jsonMap1 = {
      'email': EmailName,
      'deviceName': '${androidInfo.brand ?? iosInfo.name}'
    };
    String body1 = json.encode(jsonMap1); // encode map to json
    var res1 = await http.post(
      Uri.parse('http://$ip/user/login_info'),
      body: body1,
      headers: headers,
      encoding: encoding,
    );
  }

  LeaveFetchFun() async {
    Map<String, String> jsonMap = {'userId': "$sendDataId"};
    final headers = {'Content-Type': 'application/json'};
    String Body1 = json.encode(jsonMap); // encode map to json
    final encoding = Encoding.getByName('utf-8');
    var res = await http.post(
      Uri.parse('http://$ip/user/leave2'),
      body: Body1,
      headers: headers,
      encoding: encoding,
    );
    var jsonData = json.decode(res.body);
    allLeaveData1 = jsonData != "USERNOT" ? jsonData.length : 0;
    _showNotification();
    return jsonData;
  }
  
  
   projectList() async {
    final headers = {'Content-Type': 'application/json'};
    final encoding = Encoding.getByName('utf-8');
    Map<String, String> jsonMap1 = {
      'id': widget.sendDataId,
    };
    String body1 = json.encode(jsonMap1); // encode map to json
    var res = await http.post(
      Uri.parse('http://$ip/user/project'),
      body: body1,
      headers: headers,
      encoding: encoding,
    );

  
   var jsonData = json.decode(res.body);
    projcetCount = jsonData != "USERNOT" ? jsonData.length : 0;
 
    return jsonData;
  }


//daily notification

  Future _showNotification() async {
    initializetimezone();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    await flutterLocalNotificationsPlugin.zonedSchedule(
        10,
        'Digital Navigation',
        'Please open the attendance application',
        _nextInstanceOfTenAM(),
        const NotificationDetails(
            android: AndroidNotificationDetails("Attendance-1", 'Attendance',
                channelDescription: 'you missed out your attendance')),
          androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =  tz.TZDateTime(tz.local, now.year, now.month, now.day, 11); 
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }




}

TextStyle buildMontserrat(Color color) {
  return TextStyle(
    fontSize: 15,
    color: color,
    fontWeight: FontWeight.bold,
  );
}
