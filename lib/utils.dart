import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
// Show error massage function
void displayDialog(context, title, text) => showDialog(
  context: context,
  builder: (context) =>
      AlertDialog(title: Text(title), actions:  [
        TextButton(  onPressed: (){   Navigator.pop(context);}, child: const Text("Cancel",style: TextStyle(fontSize: 12),),)
      ],content: Text(text,style: TextStyle(fontSize: 15),)),

);
void display2(context, title, text) => showDialog(
  context: context,
  builder: (context) =>
      AlertDialog(title: title, content: text,)

);
TextStyle header = SafeGoogleFont(
  'Poppins',
  fontSize:25 ,
  fontWeight: FontWeight.w600,
  height: 1.5,
  color: Colors.white,
);
  //var ip="192.168.1.177:3000";
 var ip="103.245.200.92:50001";
TextStyle SafeGoogleFont(
  String fontFamily, {
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    return GoogleFonts.getFont(
      "Source Sans Pro",
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}


int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}
  


// code notification 


//     void _showNotification(
// {
//   String? title,
//   String? body,
//   String? payload,
//   required DateTime schedulerDate,
// }

//    ) async => await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       title,
//       body,
// _scheduleDaily(const Time(8)),
//       const NotificationDetails(
//           android: AndroidNotificationDetails("Attendance-1", 'Attendance',
//               channelDescription: 'you missed out your attendance')),
//               payload: payload,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
//     );


//   static tz.TZDateTime _scheduleDaily(Time time) {
//     final now = tz.TZDateTime.now(tz.local);
//     final schedulerDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour,time.minute,time.second);
//     return schedulerDate.isBefore(now)
//         ? schedulerDate.add(const Duration(days: 1))
//         : schedulerDate;
//   }









// tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    // // show on time
    // var next = tz.TZDateTime.now(tz.local).add(const Duration(hours: 9,minutes: 10));
    // const Map<int, String> weekdayName = {1: "Monday", 2: "Tuesday", 3: "Wednesday", 4: "Thursday", 5: "Friday", 6: "Saturday", 7: "Sunday"};
    // // print( dateFormatter(DateTime.now()));
    // for (int i =0; i < weekdayName[DateTime.now().weekday]!.length ; i++) {
    //    var x = next.add(Duration(days: i));
    //  if( weekdayName[DateTime.now().weekday] == "Sunday"){
    //    return null;
    //  }else{
    //    var x = next.add(Duration(days: i));
     
    //    await flutterLocalNotificationsPlugin.zonedSchedule( 
    //        i,
    //        'Digital Navigation',
    //        'you missed out your attendance',
    //        x,
    //        const NotificationDetails(
    //            android: AndroidNotificationDetails(
    //                "Attendance-1", 'Attendance',
    //                channelDescription: 'you missed out your attendance')),
    //        androidAllowWhileIdle: true,
    //        uiLocalNotificationDateInterpretation:
    //        UILocalNotificationDateInterpretation.absoluteTime,
    //        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime
    //    );
    //  }
    // }