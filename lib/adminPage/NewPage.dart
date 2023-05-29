import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../UI/profile.dart';
import '../location_finder.dart';
import 'package:app_settings/app_settings.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../pageloadingApiFuntion.dart/callbackFuntion.dart';
import '../utils.dart';

var rcount;

class OnlineJsonData extends StatefulWidget {
  static String id = "CalenderPage";
  var ID;
  var Name;
  var Address;
  var email;
  OnlineJsonData({super.key, this.ID, this.Name, this.email, this.Address});

  @override
  State<StatefulWidget> createState() => CalendarExample();
}

class CalendarExample extends State<OnlineJsonData> {
  var lateChcek1;
  var lateDemo;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late bool status;
//leave Check Status
  var leaveCheckStart;
  var leaveCheckend;

  var incheck;
  var outcheck;

  bool checkInState = true;
  bool checkoutState = true;

  @override
  void initState() {
    ChcekInCheck();
    super.initState();

    //notification
    var initializationSettingsAndroid = const AndroidInitializationSettings(
        '@drawable/res_notification_app_icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future initializetimezone() async {
    tz.initializeTimeZones();
  }

  Text Mytext = Text('Leave', textAlign: TextAlign.end);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getDataFromWeb(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return SafeArea(
                child: Container(
                  decoration: const BoxDecoration(color: Color(0xff1e6eee)),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20),
                        decoration:
                            const BoxDecoration(color: Color(0xff1e6eee)),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileInfo(
                                            sendDataId: widget.ID,
                                            DbuserName: widget.Name,
                                            EmailName: widget.email)));
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
                              'Attendance ',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "poppins"),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            //label info
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: const BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    const Text("Holiday"),
                                    SizedBox(
                                      width: 7,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: const BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    const Text("Leave"),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    const Text("Late"),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    const Text("Duty Off"),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: const BoxDecoration(
                                          color: Colors.brown,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                    const SizedBox(width: 7),
                                    const Text("Birthday"),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                  ],
                                )
                              ],
                            ),

                            //calender

                            Container(
                              padding: const EdgeInsets.only(top: 15),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0)),
                              ),
                              height: MediaQuery.of(context).size.height / 1.4,
                              width: 500,
                              child: SfCalendar(
                                scheduleViewSettings:
                                    const ScheduleViewSettings(),
                                view: CalendarView.month,
                                initialDisplayDate: DateTime.now(),
                                initialSelectedDate: DateTime.now(),
                                dataSource: MeetingDataSource(snapshot.data),
                                timeZone: 'India Standard Time',
                                timeSlotViewSettings:
                                    const TimeSlotViewSettings(
                                  startHour: 0,
                                  endHour: 24,
                                ),
                                appointmentTextStyle: const TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                ),
                                monthViewSettings: const MonthViewSettings(
                                  dayFormat: 'EEE',
                                  showTrailingAndLeadingDates: false,
                                  appointmentDisplayCount: 3,
                                  appointmentDisplayMode:
                                      MonthAppointmentDisplayMode.appointment,
                                  navigationDirection:
                                      MonthNavigationDirection.horizontal,
                                  agendaItemHeight: 50.0,
                                  monthCellStyle: MonthCellStyle(
                                    backgroundColor: Colors.white,
                                    todayBackgroundColor: Color(0xffffffff),
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: 'Arial'),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 40,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: !incheck['checkInStatus'] &&
                                          checkInState
                                      ? () async {
                                          _showNotification();

                                          final status = await Permission
                                              .locationWhenInUse
                                              .request();
                                          if (status ==
                                                  PermissionStatus.denied ||
                                              status ==
                                                  PermissionStatus
                                                      .permanentlyDenied) {
                                            // await openAppSettings();
                                            EasyLoading.dismiss();

                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const AlertDialog(
                                                      title: Text('Warning ! '),
                                                      content: Text(
                                                          'Please Allow Location permission For This App')),
                                            );
                                            await Future.delayed(
                                                const Duration(
                                                    milliseconds: 1500),
                                                () => AppSettings
                                                    .openLocationSettings());
                                          }
                                          if (widget.Address != null) {
                                            setState(() {
                                              checkInState = false;
                                              if (!incheck['checkInStatus']) {
                                                storeChcekInData();
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const AlertDialog(
                                                          title: Text(
                                                              ' you have already check in today'),
                                                          content: Text(
                                                              'First select checkIn')),
                                                );
                                              }
                                            });
                                          } else {
                                            await getLocPermissionGranted();
                                            final status = await Permission
                                                .locationWhenInUse
                                                .request();
                                            bool ison =
                                                await location.serviceEnabled();

                                            if (status ==
                                                    PermissionStatus.granted ||
                                                !ison) {
                                              bool isturnedon = await location
                                                  .requestService();
                                              if (isturnedon) {
                                                print(
                                                    "GPS device is turned ON");
                                                widget.Address =
                                                    await getLocation(
                                                        userType: 'new');
                                                storeChcekInData();
                                              } else {
                                                print(
                                                    "GPS Device is still OFF");
                                                AppSettings
                                                    .openLocationSettings();
                                                EasyLoading.dismiss();
                                              }
                                            } else if (status ==
                                                PermissionStatus.denied) {
                                              EasyLoading.dismiss();

                                              AppSettings
                                                  .openLocationSettings();
                                            } else if (status ==
                                                PermissionStatus
                                                    .permanentlyDenied) {
                                              EasyLoading.dismiss();

                                              AppSettings
                                                  .openLocationSettings();
                                            }
                                          }
                                        }
                                      : null,
                                  child: const Text(
                                    'Duty On',
                                    style: TextStyle(fontSize: 12),
                                  )),
                            ),
                            const SizedBox(
                              width: 60,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed:
                                    !incheck['checkOutStatus'] && checkoutState
                                        ? () async {
                                            final status = await Permission
                                                .locationWhenInUse
                                                .request();
                                            if (status ==
                                                PermissionStatus.granted) {
                                              Map newVal = await getLocation(
                                                  userType: 'new');
                                              widget.Address = newVal;
                                            }
                                            if (incheck['checkInStatus']) {
                                              storeChcekOutInData();
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    const AlertDialog(
                                                        title: Text(
                                                            '  CheckIn Require'),
                                                        content: Text(
                                                            'First select checkIn')),
                                              );
                                            }
                                          }
                                        : null,
                                child: const Text(
                                  'Duty Off',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(child: CircularProgressIndicator()),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
//notification

  Future _showNotification() async {
    initializetimezone();
   
tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    // show on time
    var next = tz.TZDateTime.now(tz.local).add(const Duration(hours: 9,minutes: 10));
    const Map<int, String> weekdayName = {1: "Monday", 2: "Tuesday", 3: "Wednesday", 4: "Thursday", 5: "Friday", 6: "Saturday", 7: "Sunday"};
    // print( dateFormatter(DateTime.now()));
    for (int i =0; i < weekdayName[DateTime.now().weekday]!.length ; i++) {
       var x = next.add(Duration(days: i));
     if( weekdayName[DateTime.now().weekday] == "Sunday"){
       return null;
     }else{
       var x = next.add(Duration(days: i));
     
       await flutterLocalNotificationsPlugin.zonedSchedule( 
           i,
           'Digital Navigation',
           'you missed out your attendance',
           x,
           const NotificationDetails(
               android: AndroidNotificationDetails(
                   "Attendance-1", 'Attendance',
                   channelDescription: 'you missed out your attendance')),
           androidAllowWhileIdle: true,
           uiLocalNotificationDateInterpretation:
           UILocalNotificationDateInterpretation.absoluteTime,
           matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
       );
     }
    }
    
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 20, 10);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  // this is the main function to run ++ or show calender  history
  Future<List<Meeting>> getDataFromWeb() async {
    final List<Meeting> appointmentData = [];
    Map<String, String> jsonMap = {'userId': widget.ID};
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

    //////////////////////////LEAVE////////////////////////////////////
    Map<String, String> jsonLEV = {'userId': widget.ID};
    String Body = json.encode(jsonLEV); // encode map to json
    var res1 = await http.post(
      Uri.parse('http://$ip/user/leave2'),
      body: Body,
      headers: headers,
      encoding: encoding,
    );
    var jsonData1 = json.decode(res1.body);

//////////////////////////HOLIDAY////////////////////////////////////
    var res2 = await http.get(
      Uri.parse('http://$ip/user/holiday'),
      headers: headers,
    );
    var jsonData2 = json.decode(res2.body);

/////////////////////////Birthday
    var res3 = await http.get(
      Uri.parse('http://$ip/user/birthday'),
      headers: headers,
    );
    var jsonData3 = json.decode(res3.body);

    try {
      //Birthday LOOP
      for (var data in jsonData3) {
        String Birthday = data['dob'];

        String Name = data['name'];
        var demo = Birthday.split("-");
        DateTime now = DateTime.now();

        //  var raj = currentdate.toString().split('-');
        var demo1 = "${now.year}-${demo[1]}-${demo[2]}";

        print(demo1);

        leaveCheckStart = data['leave_from'];
        leaveCheckend = data['leave_to'];
        Meeting meetingData = Meeting(
            eventName: "${Name.split(" ")[0] + ' Bday'}",
            startTimeZone: 'India Standard Time',
            endTimeZone: 'India Standard Time',
            from: DateTime.parse('$demo1 01:03:55.000'),
            to: DateTime.parse('$demo1 01:03:55.000'),
            background: Colors.brown,
            allDay: true);
        appointmentData.add(meetingData);
      }
      //change
      lateChcek1 = await lateChcek();

      // checkin checkout
      for (var data in jsonData) {
        lateDemo = data["user_checkin"];

        var backenDdata = DateTime.parse(lateChcek1);
        var latedatemin = DateTime.parse(lateDemo);

        int officeInTime = backenDdata.hour * 60 + 15;
        int Intime = latedatemin.hour * 60 + latedatemin.minute;

        String checkinDate = data['user_checkin'];
        String checkOutDate = data['user_checkout'];
        String Timein = checkinDate.split(' ')[1];
        String Timeout = checkOutDate.split(' ')[1];
        Meeting meetingData = Meeting(
            eventName: 'In:' '$Timein',
            startTimeZone: 'India Standard Time',
            endTimeZone: 'India Standard Time',
            from: DateTime.parse('$checkinDate.000'),
            to: DateTime.parse('$checkOutDate.000'),
            background: officeInTime < Intime ? Colors.red : Color(0xff1e6eee),
            allDay: true);
        appointmentData.add(meetingData);
        if (Timein != Timeout) {
          Meeting meetingData1 = Meeting(
              eventName: 'Out:' '$Timeout',
              startTimeZone: 'India Standard Time',
              endTimeZone: 'India Standard Time',
              from: DateTime.parse((data['user_checkout']) + '.000'),
              to: DateTime.parse((data['user_checkout']) + '.000'),
              background: Colors.orange,
              allDay: true);
          appointmentData.add(meetingData1);
        }
      }
      rcount = appointmentData.length / 2;

      // HOLIDAY LOOPr
      for (var data in jsonData2) {
        String HoliDay = data['date'];
        String HoliDayName = data['holiday_name'];
        Meeting meetingData = Meeting(
            eventName: HoliDayName,
            startTimeZone: 'India Standard Time',
            endTimeZone: 'India Standard Time',
            from: DateTime.parse('$HoliDay 01:03:55.000'),
            to: DateTime.parse('$HoliDay 20:03:55.000'),
            background: Colors.deepPurple,
            allDay: true);
        appointmentData.add(meetingData);
      }

      //LEAVE LOOP
      for (var data in jsonData1) {
        String LeveDate = data['leave_from'];
        String EndDate = data['leave_to'];
        leaveCheckStart = data['leave_from'];
        leaveCheckend = data['leave_to'];
        Meeting meetingData = Meeting(
            eventName: Mytext.data,
            startTimeZone: 'India Standard Time',
            endTimeZone: 'India Standard Time',
            from: DateTime.parse('$LeveDate 01:03:55.000'),
            to: DateTime.parse('$EndDate 20:03:55.000'),
            background: Colors.green,
            allDay: true);
        appointmentData.add(meetingData);
      }

      return appointmentData;
    } catch (e) {
      print(e);
    }

    return appointmentData;
  }

  ChcekInCheck() async {
    // post data
    Map<String, dynamic> jsonMap = {
      "userId": widget.ID,
    };
    final headers = {'Content-Type': 'application/json'};
    // ignore: non_constant_identifier_names
    String Body = json.encode(jsonMap); // encode map to json
    final encoding = Encoding.getByName('utf-8');
    var res = await http.post(
      Uri.parse('http://$ip/user/login/checkStaus'),
      body: Body,
      headers: headers,
      encoding: encoding,
    );

    try {
      if (res.statusCode == 200) {
        print('your checking funtion is working ');
      } else {
        print('Not working  $res');
      }
    } catch (e) {
      print('Not  working ');
    }
    incheck = jsonDecode(res.body);

    if (incheck['checkOutStatus'] == false) {
      checkoutState = true;
    } else {
      checkoutState = false;
    }
  }

  // Check In  or  Check Out function
  Future<dynamic> storeChcekInData() async {
    // ignore: non_constant_identifier_names
    var lat = widget.Address['lat'];
    var long = widget.Address['long'];
    var addr = widget.Address['add'];
    Map<String, dynamic> jsonMap = {
      "userId": widget.ID,
      "longLat": "$lat ~ $long ! $addr"
    };
    final headers = {'Content-Type': 'application/json'};
    String Body1 = json.encode(jsonMap); // encode map to json
    final encoding = Encoding.getByName('utf-8');
    var res = await http.post(
      Uri.parse('http://$ip/user/checkin'),
      body: Body1,
      headers: headers,
      encoding: encoding,
    );
    await Future.delayed(const Duration(milliseconds: 0),
        () => EasyLoading.show(status: 'Please Wait...'));
    try {
      EasyLoading.dismiss();
      incheck['checkInStatus'] = true;

      setState(() {
       getDataFromWeb();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> storeChcekOutInData() async {
    var lat = widget.Address['lat'];
    var long = widget.Address['long'];
    var addr = widget.Address['add'];
    Map<String, dynamic> jsonMap = {
      "userId": widget.ID,
      "longLat": "$lat ~ $long ! $addr"
    };
    final headers = {'Content-Type': 'application/json'};
    String body = json.encode(jsonMap); // encode map to json
    final encoding = Encoding.getByName('utf-8');
    var res = await http.post(
      Uri.parse('http://$ip/user/checkout'),
      body: body,
      headers: headers,
      encoding: encoding,
    );
    await Future.delayed(const Duration(milliseconds: 0),
        () => EasyLoading.show(status: 'Please Wait...'));
    try {
      EasyLoading.dismiss();
      setState(() {
      getDataFromWeb();
      });
      checkoutState = false;
    } catch (e) {
      print(e);
    }
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].allDay;
  }
}

class Meeting {
  Meeting(
      {this.eventName,
      this.from,
      this.to,
      this.background,
      this.allDay = false,
      required this.startTimeZone,
      required this.endTimeZone});

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? allDay;
  String startTimeZone;
  String endTimeZone;
}
