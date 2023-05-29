import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_aap/UI/profile.dart';
import '../main.dart';

class MainPage extends StatefulWidget {

 static String  id  ="flashPage";
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  
  var storage = const FlutterSecureStorage();
  var Address ;
  @override
  void initState() {
    super.initState();
    _navigation();

    
  }

  _navigation() async {
    await Future.delayed(const Duration(milliseconds: 1000),);
    var st = await storage.read(key: 'userId');
    var name = await storage.read(key: 'userName');
    var email = await storage.read(key:'email');
    Navigator.of(context).pushAndRemoveUntil(
      // the new route
      MaterialPageRoute(
        builder: (BuildContext context) => st !=null? ProfileInfo(  sendDataId:st,DbuserName: name,EmailName: email ):const Home(),
      ),

          (Route route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body:  SizedBox(
        width: double.infinity,
        child: Container(
          // iphone1313pro2Doa (62:10)
          width: double.infinity,

          decoration: const BoxDecoration (
            color: Color(0xffffffff),
          ),
          child: Stack(
            children: [
              Positioned(
                // vector4UmS (64:7)
                left: 0*fem,
                top: 538*fem,

                child: Align(
                  child: Container(
                    width: 391*fem,
                    height: 385*fem,
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/50, left: 0,right: 0),
                    child: Image.asset(
                      'assets/page-1/images/vector-4.png',
                        fit:BoxFit.cover
                    ),
                  ),
                ),
              ),
              Positioned(
                // dn1xwW (65:10)
                left: 85*fem,
                top: 240*fem,
                child: Align(
                  child: SizedBox(
                    width: 254*fem,
                    height: 138*fem,
                    child: Image.asset(
                      'assets/page-1/images/dn-1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }


}
