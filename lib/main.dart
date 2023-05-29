
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_aap/UI/LevesData.dart';
import 'package:my_aap/UI/leavesPage.dart';
import 'package:my_aap/UI/profile.dart';
import 'package:my_aap/UI/projcet.dart';
import 'package:my_aap/adminPage/NewPage.dart';
import 'package:my_aap/auth/login copy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Api/sendData.dart';
import 'UI/holidayList.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    builder: EasyLoading.init(),
    initialRoute:    MainPage.id,
    routes: {
      MainPage.id: (context)=> MainPage(),
      Login.id : (context)=> Login(),
      ProfileInfo.id:(context)=> ProfileInfo(),
      OnlineJsonData.id:(context)=> OnlineJsonData(),
      Leaves.id:(context)=> Leaves(),
      LeaveShow.id:(context)=>LeaveShow(),
      Holiday.id:(context)=>Holiday(),
      ProjectList.id:(context)=>ProjectList()

    },
    theme:ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(),
  )));
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

int selectedIndex = 0;

class _HomeState extends State<Home> {
  final _storage = const FlutterSecureStorage();
  // Position? _position ;

  readData() async {
    var myloginData = await _storage.read(key: 'userId');
    return myloginData;
  }



  @override
  void initState() {
    super.initState();
    //getloc();
  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      body: Center(
        child: Login(),
      ),

    );
  }
}
