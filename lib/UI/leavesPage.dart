import 'dart:convert';
import 'package:http/http.dart' as http;
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_aap/UI/profile.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../utils.dart';


class Leaves extends StatefulWidget {
  static String  id = "LeavesPage";
  var ID;
  var Name;
  var Address;
  var email;
  Leaves({super.key, this.ID, this.Name, this.email, this.Address});
  @override
  State<Leaves> createState() => _LeavesState();
}

enum SingingCharacter { fullDay, halfDay }

class _LeavesState extends State<Leaves> {
 var data;
  List<SelectDrop> _region = [];

   int? selectedRegion;

 List<SelectDrop> selectedRegionName = [];
  var  _typeDay = SingingCharacter.fullDay;
  final DateRangePickerController _controller = DateRangePickerController();
  late TextEditingController _commentController;
 var  getTotalDate ="0";
 @override
  void initState() {
    _commentController = TextEditingController();
    leaveType();
    setState(() {
      super.initState();
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _controller.dispose();
    super.dispose();
  }
 final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    final args = ModalRoute.of(context)!.settings.arguments as Leaves;
    var changeType = _typeDay.toString().replaceAll("SingingCharacter.", "");

    var startDate ;
    var endDate ;

if(changeType == "halfDay"){
  startDate = _controller.selectedRange != null
      ? _controller.selectedRange!.startDate.toString().split(' ')[0]
      : "Set Start Date ";
  endDate = _controller.selectedRange != null
      ? _controller.selectedRange!.startDate.toString().split(' ')[0]
      : "Set End Date " ;
}else{
  startDate = _controller.selectedRange != null
    ? _controller.selectedRange!.startDate.toString().split(' ')[0]
        : "Set Start Date ";

  endDate = _controller.selectedRange != null
      ? _controller.selectedRange!.endDate.toString().split(' ')[0]
      : "Set End Date " ;

  print("$endDate: Set End Date ");

  if(endDate == "null"){
    print("1 Set End Date ");
    endDate = "One Day Leave";
  }
}

    double daysBetween( from,  to) {
     var endate = to.add(Duration(days: 1));
  if(from == null || to == null){
   return 0;
  }else if(changeType == "halfDay"){
       return 0.5;
      }else if(changeType == "fullDay" && to == from ){
        return 1.0;

      }else{
        from = from != null
            ? DateTime(from.year, from.month, from.day)
            : DateTime.now();


        to = to != null ? DateTime(to.year, to.month, to.day) : DateTime.now();
       print((to.difference(from).inHours / 24));

        return (endate.difference(from).inHours / 24);
      }

    }

     getTotalDate = daysBetween(DateTime.parse(_controller.selectedRange != null ? _controller.selectedRange!.startDate.toString() : DateTime.now().toString()),
              _controller.selectedRange != null
                  ? DateTime.parse(_controller.selectedRange?.endDate != null ? _controller.selectedRange!.endDate.toString() : _controller.selectedRange!.startDate.toString())
                  : DateTime.now()).toString() ;
            
 print("getTotalDate $getTotalDate");


    ApiCall( {from, to, leaveType, days, comment, leavecate,Typename}) async {

      Map<String, dynamic> jsonMap = {
        "userId": args.ID,
        "email": args.email,
        "leavefrom":from,
        "leaveto":to == "null" ? from : to,
        "leavetype":leavecate,
        "days":days,
        "leavecomment":comment,
        "leavecategory": leaveType,
        "Typename": Typename,
        "Name": args.Name
      };

      final headers = {'Content-Type': 'application/json'};
      String Body = json.encode(jsonMap); // encode map to json
      final encoding = Encoding.getByName('utf-8');
      var res = await http.post(
        Uri.parse('http://$ip/user/leave'),
        body: Body,
        headers: headers,
        encoding: encoding,
      );

      try {
        if (res.statusCode == 200) {
          print('your checking funtion is working ');
        } else {
          print('Not working 1  $res');
        }
      } catch (e) {
        print('Not  working 2 ');
      }
    }

    return Scaffold(
         backgroundColor: Colors.white,
        body: SingleChildScrollView(

      child: Container(

        decoration: const BoxDecoration(color: Color(0xff1e6eee)),
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
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
                    'Leave Request',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "poppins"),
                  ),
                ],
              ),
            ),
         
         
         
          Form(
            key: _formKey,
          child:   Container(
            padding: const EdgeInsets.only(top: 30, left: 20 ,right: 20),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    topRight: Radius.circular(60.0)),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 150,
                        decoration: const BoxDecoration(
                            color:Colors.white60,
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
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio(
                              value: SingingCharacter.fullDay,
                              groupValue: _typeDay,
                              onChanged: ( value) {
                                setState(() {
                                  _typeDay = value!;
                                });
                              },
                            ),
                            const Text(
                              "Full Day",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 150,
                        decoration: const BoxDecoration(
                            color:Colors.white60,
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
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio(
                              value: SingingCharacter.halfDay,
                              groupValue: _typeDay,
                              onChanged: ( value) {
                                setState(() {
                                  _typeDay = value!;
                                });
                              },
                            ),
                            const Text(
                              "Half Day",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(
                  color: Colors.black,
                  height: 36,
                ),
                const SizedBox(
                  height: 30,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [
                            Colors.blue,
                            Color(0xff1e4eee),
                            //add more colors
                          ]),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Padding(
                      padding: const EdgeInsets.only(left:30, right:30),
                      child: DropdownButton<int>(
                        value:selectedRegion,
                        icon: const Icon(Icons.arrow_downward,color: Colors.white54,),
                        elevation: 16,
                        onChanged: (int? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            // dropdownValue = value!;
                            selectedRegion = value!;
                            selectedRegionName = _region.where((o) => o.regionid == value).toList();
                          });

                        },
                        items: _region.map((SelectDrop map) {
                          return  DropdownMenuItem<int>(
                            value: map.regionid,
                            child:  Text(map.regionDescription,
                                style:  const TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        isExpanded: true, //make true to take width of parent widget
                        underline: Container(), //empty line
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                        dropdownColor: Colors.blue,
                        iconEnabledColor: Colors.white,
                        //Icon color
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width/1.2,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: const BoxDecoration(
                              color:Colors.white60,
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    display2(
                                        context,
                                        const Text(
                                          "SELECT START DATE OR END DATE ",
                                          style: TextStyle(fontSize: 1),
                                        ),
                                        Card(
                                          child: SizedBox(
                                            width: 400,
                                            height: 500,
                                            child: SfDateRangePicker(
                                              headerHeight: 40,
                                              showTodayButton: true,
                                              controller: _controller,
                                              enablePastDates: false,
                                              monthCellStyle: const DateRangePickerMonthCellStyle(
                                                  specialDatesTextStyle: TextStyle(color: Colors.black),
                                                  cellDecoration: BoxDecoration(shape: BoxShape.circle),
                                                  todayTextStyle: TextStyle(color: Colors.white),
                                                  todayCellDecoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                                                  ),
                                              showActionButtons: true,
                                              cancelText: 'CANCEL',
                                              confirmText: 'OK',
                                              onSubmit: (value) {
                                                setState(() {
                                                  Navigator.pop(
                                                      context, _controller);
                                                });
                                              },
                                              onCancel: () {
                                                setState(() {
                                                  Navigator.pop(
                                                      context,
                                                      _controller ==
                                                          DateTime.now());
                                                });
                                              },
                                              selectionMode:
                                              DateRangePickerSelectionMode
                                                  .range,
                                              allowViewNavigation: false,
                                            ),
                                          ),
                                        ));
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        '$startDate  $endDate ',
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                      const Icon(
                                        Icons.calendar_month,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  )),

                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 49,
                    decoration: const BoxDecoration(color: Color(0xff1e6eee),
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
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
                    ),
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      textAlign: TextAlign.center,
                     
                      "Number Of Days : ${ _controller.selectedRange  != null ? getTotalDate : "0"} ",
                      style: const TextStyle(color: Colors.white),
                    )),

                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 5 * 24.0,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration:   const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  ),
                  child: TextFormField(
                    controller: _commentController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Reason",
                      fillColor: Colors.transparent,
                      filled: true,

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {

                              if(_commentController.text.isEmpty ||  getTotalDate == "0.0"  || selectedRegion == 0){
                              if(selectedRegion == 0){
                                displayDialog(context , "Warning !","Please select leave reason type.");
                              }else if(  getTotalDate == "0.0"){
                                displayDialog(context , " Warning !","Please select date ");

                              }else if(_commentController.text.isEmpty  ){

                                displayDialog(context , "Warning !","Please enter the reason");
                              }

                              }else{
                                ApiCall(from: startDate, to:endDate =="One Day Leave"? startDate :endDate,leaveType: changeType,days:getTotalDate,comment:_commentController.text.toString(),leavecate:selectedRegion,Typename: selectedRegionName[0].regionDescription.toString());
                                //  ProfileInfo
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(

                                      builder: (context) => ProfileInfo(
                                          sendDataId: args.ID,
                                          DbuserName: args.Name,
                                          EmailName: args.email),
                                    ));
                              }
                            }


                          ,
                          child: const Text('Submit')),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          )

          ],
        ),
      ),
    ));
  }

  leaveType() async {
    final headers = {'Content-Type': 'application/json'};
    var res = await http.get(
      Uri.parse('http://$ip/user/leavetype'),
      headers: headers,
    );
    setState(() {
  data =   res.body;
  final json = JsonDecoder().convert(data);
  _region = (json).map<SelectDrop>((item) => SelectDrop.fromJson(item)).toList();
  selectedRegion = _region[0].regionid;
  
   });
  }
}
class SelectDrop {
  final int regionid;
  final String regionDescription;
  SelectDrop({required this.regionid, required this.regionDescription});
  factory SelectDrop.fromJson(Map<String, dynamic> json) {
    return  SelectDrop(
        regionid: json['trans_id'], regionDescription: json['leave_type']);
  }
}






















// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:my_aap/UI/profile.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import '../utils.dart';


// class Leaves extends StatefulWidget {
//   static String  id = "LeavesPage";
//   var ID;
//   var Name;
//   var Address;
//   var email;
//   Leaves({super.key, this.ID, this.Name, this.email, this.Address});
//   @override
//   State<Leaves> createState() => _LeavesState();
// }

// enum SingingCharacter { fullDay, halfDay }

// class _LeavesState extends State<Leaves> {
//  var data;
//   List<SelectDrop> _region = [];

//    int? selectedRegion;

//  List<SelectDrop> selectedRegionName = [];
//   var  _typeDay = SingingCharacter.fullDay;
//   final DateRangePickerController _controller = DateRangePickerController();
//   late TextEditingController _commentController;
//  var  getTotalDate;
//  @override
//   void initState() {
//     _commentController = TextEditingController();
//     leaveType();
//     setState(() {

//       super.initState();
//     });
//   }

//   @override
//   void dispose() {
//     _commentController.dispose();
//     _controller.dispose();
//     super.dispose();
//   }
//  final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {


//     final args = ModalRoute.of(context)!.settings.arguments as Leaves;

//     var changeType = _typeDay.toString().replaceAll("SingingCharacter.", "");

//     var startDate ;
//     var endDate ;

// if(changeType == "halfDay"){
//   startDate = _controller.selectedRange != null
//       ? _controller.selectedRange!.startDate.toString().split(' ')[0]
//       : "Set Start Date ";
//   endDate = _controller.selectedRange != null
//       ? _controller.selectedRange!.startDate.toString().split(' ')[0]
//       : "Set End Date " ;
// }else{
//   startDate = _controller.selectedRange != null
//     ? _controller.selectedRange!.startDate.toString().split(' ')[0]
//         : "Set Start Date ";

//   endDate = _controller.selectedRange != null
//       ? _controller.selectedRange!.endDate.toString().split(' ')[0]
//       : "Set End Date " ;

//   print("$endDate: Set End Date ");

//   if(endDate == "null"){
//     print("1 Set End Date ");
//     endDate = "One Day Leave";
//   }
// }

//     double daysBetween(DateTime from, DateTime to) {
//       if(changeType == "halfDay"){
//        return 0.5;
//       }else if(changeType == "fullDay" && to == from ){
//         return 1.0;

//       }else{
//         from = from != null
//             ? DateTime(from.year, from.month, from.day)
//             : DateTime.now();
//         to = to != null ? DateTime(to.year, to.month, to.day) : DateTime.now();
//         return (to.difference(from).inHours / 24);
//       }

//     }

// // date count
//      getTotalDate = daysBetween(DateTime.parse(_controller.selectedRange != null ? _controller.selectedRange!.startDate.toString() : DateTime.now().toString()),
//               _controller.selectedRange != null
//                   ? DateTime.parse(_controller.selectedRange?.endDate != null ? _controller.selectedRange!.endDate.toString() : _controller.selectedRange!.startDate.toString())
//                   : DateTime.now()).toString() ;



//     ApiCall( {from, to, leaveType, days, comment, leavecate,Typename}) async {

//       Map<String, dynamic> jsonMap = {
//         "userId": args.ID,
//         "email": args.email,
//         "leavefrom":from,
//         "leaveto":to == "null" ? from : to,
//         "leavetype":leavecate,
//         "days":days,
//         "leavecomment":comment,
//         "leavecategory": leaveType,
//         "Typename": Typename,
//         "Name": args.Name
//       };

//       final headers = {'Content-Type': 'application/json'};

//       String Body = json.encode(jsonMap); // encode map to json
//       final encoding = Encoding.getByName('utf-8');
//       var res = await http.post(
//         Uri.parse('http://$ip/user/leave'),
//         body: Body,
//         headers: headers,
//         encoding: encoding,
//       );

//       try {
//         if (res.statusCode == 200) {
//           print('your checking funtion is working ');
//         } else {
//           print('Not working 1  $res');
//         }
//       } catch (e) {
//         print('Not  working 2 ');
//       }
//     }

//     return Scaffold(
//          backgroundColor: Colors.white,
//         body: SingleChildScrollView(

//       child: Container(

//         decoration: const BoxDecoration(color: Color(0xff1e6eee)),
//         child: Column(
//           children: <Widget>[
//             Container(
//               padding:
//                   const EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
//               child: Row(
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ProfileInfo(
//                                   sendDataId: args.ID,
//                                   DbuserName: args.Name,
//                                   EmailName: args.email)));
//                     },
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   const Text(
//                     'Leave Request',
//                     style: TextStyle(
//                         fontSize: 25,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: "poppins"),
//                   ),
//                 ],
//               ),
//             ),
//           Form(
//             key: _formKey,
//           child:   Container(
//             padding: const EdgeInsets.only(top: 30, left: 20 ,right: 20),
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(60.0),
//                     topRight: Radius.circular(60.0)),
//                 color: Colors.white),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(
//                         width: 150,
//                         decoration: const BoxDecoration(
//                             color:Colors.white60,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 offset: Offset(
//                                   5.0,
//                                   5.0,
//                                 ),
//                                 blurRadius: 10.0,
//                                 spreadRadius: 2.0,
//                               ), //BoxShadow
//                               BoxShadow(
//                                 color: Colors.white,
//                                 offset: Offset(0.0, 0.0),
//                                 blurRadius: 0.0,
//                                 spreadRadius: 0.0,
//                               ),
//                             ],
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(10))),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Radio(
//                               value: SingingCharacter.fullDay,
//                               groupValue: _typeDay,
//                               onChanged: ( value) {
//                                 setState(() {
//                                   _typeDay = value!;
//                                 });
//                               },
//                             ),
//                             const Text(
//                               "Full Day",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ],
//                         ),
//                       ),

//                       Container(
//                         width: 150,
//                         decoration: const BoxDecoration(
//                             color:Colors.white60,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 offset: Offset(
//                                   5.0,
//                                   5.0,
//                                 ),
//                                 blurRadius: 10.0,
//                                 spreadRadius: 2.0,
//                               ), //BoxShadow
//                               BoxShadow(
//                                 color: Colors.white,
//                                 offset: Offset(0.0, 0.0),
//                                 blurRadius: 0.0,
//                                 spreadRadius: 0.0,
//                               ),
//                             ],
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(10))),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Radio(
//                               value: SingingCharacter.halfDay,
//                               groupValue: _typeDay,
//                               onChanged: ( value) {
//                                 setState(() {
//                                   _typeDay = value!;
//                                 });
//                               },
//                             ),
//                             const Text(
//                               "Half Day",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Divider(
//                   color: Colors.black,
//                   height: 36,
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 DecoratedBox(
//                   decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                           colors: [
//                             Colors.blue,
//                             Color(0xff1e4eee),
//                             //add more colors
//                           ]),
//                       borderRadius: BorderRadius.circular(5),
//                       boxShadow: const <BoxShadow>[
//                         BoxShadow(
//                             color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
//                             blurRadius: 5) //blur radius of shadow
//                       ]
//                   ),
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width / 1.2,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left:30, right:30),
//                       child: DropdownButton<int>(
//                         value:selectedRegion,
//                         icon: const Icon(Icons.arrow_downward,color: Colors.white54,),
//                         elevation: 16,
//                         onChanged: (int? value) {
//                           // This is called when the user selects an item.
//                           setState(() {
//                             // dropdownValue = value!;
//                             selectedRegion = value!;
//                             selectedRegionName = _region.where((o) => o.regionid == value).toList();
//                           });

//                         },
//                         items: _region.map((SelectDrop map) {
//                           return  DropdownMenuItem<int>(
//                             value: map.regionid,
//                             child:  Text(map.regionDescription,
//                                 style:  const TextStyle(color: Colors.white)),
//                           );
//                         }).toList(),
//                         isExpanded: true, //make true to take width of parent widget
//                         underline: Container(), //empty line
//                         style: const TextStyle(fontSize: 18, color: Colors.white),
//                         dropdownColor: Colors.blue,
//                         iconEnabledColor: Colors.white,
//                         //Icon color
//                       ),
//                     ),
//                   ),
//                 ),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: <Widget>[
//                         Container(
//                           height: 70,
//                           width: MediaQuery.of(context).size.width/1.2,
//                           margin: const EdgeInsets.only(top: 20),
//                           decoration: const BoxDecoration(
//                               color:Colors.white60,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black12,
//                                   offset: Offset(
//                                     5.0,
//                                     5.0,
//                                   ),
//                                   blurRadius: 10.0,
//                                   spreadRadius: 2.0,
//                                 ), //BoxShadow
//                                 BoxShadow(
//                                   color: Colors.white,
//                                   offset: Offset(0.0, 0.0),
//                                   blurRadius: 0.0,
//                                   spreadRadius: 0.0,
//                                 ),
//                               ],
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(10))),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               TextButton(
//                                   onPressed: () {
//                                     display2(
//                                         context,
//                                         const Text(
//                                           "SELECT START DATE OR END DATE ",
//                                           style: TextStyle(fontSize: 1),
//                                         ),
//                                         Card(
//                                           child: SizedBox(
//                                             width: 400,
//                                             height: 500,
//                                             child: SfDateRangePicker(
//                                               headerHeight: 40,
//                                               showTodayButton: true,
//                                               controller: _controller,
//                                               enablePastDates: false,
//                                               monthCellStyle: const DateRangePickerMonthCellStyle(
//                                                   specialDatesTextStyle: TextStyle(color: Colors.black),
//                                                   cellDecoration: BoxDecoration(shape: BoxShape.circle),
//                                                   todayTextStyle: TextStyle(color: Colors.white),
//                                                   todayCellDecoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
//                                                   ),
//                                               showActionButtons: true,
//                                               cancelText: 'CANCEL',
//                                               confirmText: 'OK',
//                                               onSubmit: (value) {
//                                                 setState(() {
//                                                   Navigator.pop(
//                                                       context, _controller);
//                                                 });
//                                               },
//                                               onCancel: () {
//                                                 setState(() {
//                                                   Navigator.pop(
//                                                       context,
//                                                       _controller ==
//                                                           DateTime.now());
//                                                 });
//                                               },
//                                               selectionMode:
//                                               DateRangePickerSelectionMode
//                                                   .range,
//                                               allowViewNavigation: false,
//                                             ),
//                                           ),
//                                         ));
//                                   },
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         '$startDate  $endDate ',
//                                         style: const TextStyle(color: Colors.black),
//                                       ),
//                                       const Icon(
//                                         Icons.calendar_month,
//                                         color: Colors.black54,
//                                       ),
//                                     ],
//                                   )),

//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                     width: MediaQuery.of(context).size.width / 1.2,
//                     height: 49,
//                     decoration: const BoxDecoration(color: Color(0xff1e6eee),
//                       borderRadius:
//                       BorderRadius.all(Radius.circular(5)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           offset: Offset(
//                             5.0,
//                             5.0,
//                           ),
//                           blurRadius: 10.0,
//                           spreadRadius: 2.0,
//                         ), //BoxShadow
//                         BoxShadow(
//                           color: Colors.white,
//                           offset: Offset(0.0, 0.0),
//                           blurRadius: 0.0,
//                           spreadRadius: 0.0,
//                         ),
//                       ],
//                     ),
//                     padding: const EdgeInsets.only(top: 15),
//                     child: Text(
//                       textAlign: TextAlign.center,
//                       "Number Of Days : $getTotalDate ",
//                       style: const TextStyle(color: Colors.white),
//                     )),

//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(right: 10),
//                   height: 5 * 24.0,
//                   width: MediaQuery.of(context).size.width / 1.2,
//                   decoration:   const BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         offset: Offset(
//                           5.0,
//                           5.0,
//                         ),
//                         blurRadius: 10.0,
//                         spreadRadius: 2.0,
//                       ), //BoxShadow
//                       BoxShadow(
//                         color: Colors.white,
//                         offset: Offset(0.0, 0.0),
//                         blurRadius: 0.0,
//                         spreadRadius: 0.0,
//                       ),
//                     ],
//                   ),
//                   child: TextFormField(
//                     controller: _commentController,
//                     maxLines: 5,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Reason",
//                       fillColor: Colors.transparent,
//                       filled: true,

//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter some text';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                           onPressed: () {

//                               if(_commentController.text.isEmpty ||  getTotalDate == "0.0"  || selectedRegion == 0){
//                               if(selectedRegion == 0){
//                                 displayDialog(context , "Warning !","Please select leave reason type.");
//                               }else if(  getTotalDate == "0.0"){
//                                 displayDialog(context , " Warning !","Please select date ");

//                               }else if(_commentController.text.isEmpty  ){

//                                 displayDialog(context , "Warning !","Please enter the reason");
//                               }

//                               }else{
//                                 ApiCall(from: startDate, to:endDate =="One Day Leave"? startDate :endDate,leaveType: changeType,days:getTotalDate,comment:_commentController.text.toString(),leavecate:selectedRegion,Typename: selectedRegionName[0].regionDescription.toString());
//                                 //  ProfileInfo
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(

//                                       builder: (context) => ProfileInfo(
//                                           sendDataId: args.ID,
//                                           DbuserName: args.Name,
//                                           EmailName: args.email),
//                                     ));
//                               }
//                             }


//                           ,
//                           child: const Text('Submit')),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           )

//           ],
//         ),
//       ),
//     ));

//   }

//   leaveType() async {
//     final headers = {'Content-Type': 'application/json'};
//     var res = await http.get(
//       Uri.parse('http://$ip/user/leavetype'),
//       headers: headers,
//     );
//     setState(() {
//   data =   res.body;
//   final json = JsonDecoder().convert(data);
//   _region = (json).map<SelectDrop>((item) => SelectDrop.fromJson(item)).toList();
//   selectedRegion = _region[0].regionid;
  
//    });
//   }
// }


// class SelectDrop {
//   final int regionid;
//   final String regionDescription;
//   SelectDrop({required this.regionid, required this.regionDescription});
//   factory SelectDrop.fromJson(Map<String, dynamic> json) {
//     return  SelectDrop(
//         regionid: json['trans_id'], regionDescription: json['leave_type']);
//   }
// }