import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_aap/UI/profile.dart';

import '../utils.dart';
import 'package:http/http.dart' as http;
class Holiday extends StatefulWidget {
  var ID;
  var Name;
  var email;
   Holiday({Key? key , this.ID ,this.Name,this.email}) : super(key: key);
  static String id =  "HolidayPage" ;
  @override
  State<Holiday> createState() => _HolidayState();
}
class _HolidayState extends State<Holiday> {


  @override
  void initState() {

    super.initState();

  }


  String _festival(dynamic holidayname){
    return holidayname['holiday_name'];

  }

  Dateformete(mydate){
    final moonLanding = DateTime.parse(mydate);
    switch(moonLanding.month) {
      case 1: {
        // statements;
      
        var date= moonLanding.day;
        List<String> dateArray = [date.toString(),"Jan"];
        return dateArray;
      }
      break;

      case 2: {
        //statements;

      
        var date= moonLanding.day;
        List<String>  dateArray = [date.toString(),"Feb"];
        return dateArray;
      }
      break;
      case 3: {
        //statements;

   
        var date= moonLanding.day;
        List<String>  dateArray = [date.toString(),"Mar"];
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
        //statements;

     
        var date= moonLanding.day;

        List<String>  dateArray = [date.toString(),"May"];
        return dateArray;
      }
      break;
      case 6: {
        //statements;

   
        var date= moonLanding.day;

        List<String>  dateArray = [date.toString(),"Jun"];
        return dateArray;
      }
      break;

      case 7: {
        //statements;

      
        var date= moonLanding.day;

        List<String>  dateArray = [date.toString(),"Jul"];
        return dateArray;
      }
      break;
      case 8: {
        //statements;

       
        var date= moonLanding.day;

        List<String>  dateArray = [date.toString(),"Aug"];
        return dateArray;
      }
      break;

      case 9: {
        //statements;
    
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
        //statements;
      
        var date= moonLanding.day;
        List<String>  dateArray = [date.toString(),"Nov"];
        return dateArray;
      }
      break;
      case 12: {
        //statements;
       
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

  @override
  Widget build(BuildContext context) {
     var width =  MediaQuery.of(context).size.width;
     var height =  MediaQuery.of(context).size.height;

    return FutureBuilder(
        future:   holiday_list(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return Scaffold(
              body: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(color: Color(0xff1e6eee)),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child:  Stack(children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push( context, MaterialPageRoute( builder: (BuildContext context) => ProfileInfo(sendDataId:widget.ID,DbuserName: widget.Name,EmailName:widget.email) ));
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color:Colors.white ,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Holiday',
                            style:header,
                          ),

                        ],
                      ),
                    ),
                    Positioned(
                      top: 100,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: height,
                        padding: EdgeInsets.only(bottom: 140 ,top: 20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:BorderRadius.only( topLeft: Radius.circular(30.0) , topRight: Radius.circular(30.0))),
                        child:ListView.builder(

                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {

                            List<String> ourMount=  Dateformete(snapshot.data[index]["date"]);
                            return Container(
                              height: 70,
                              padding: const EdgeInsets.only(top: 5 ,left: 20 , right: 20,),
                              child: Row(
                                children:  [
                                  Expanded(
                                      flex:1,
                                      child: Container(
                                        color: Colors.white,
                                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                          children:  [
                                            Text(ourMount[1].toString(),style: TextStyle(fontSize: 13,)),
                                            Text(ourMount[0].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                                          ],
                                        ),
                                      )),

                                  SizedBox(width: 5,),
                                  Expanded(flex: 6, child: Container(
                                    alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 20 , right: 20,),
                                      decoration: const BoxDecoration(
                                          color: Color(0xff1e6eee),
                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                      ),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,

                                      child:  Text(_festival(snapshot.data[index]), style: TextStyle(fontSize:15 ,color: Colors.white,fontWeight: FontWeight.w600),))),

                                ],),) ;
                          },),

                      ),
                    ),
                  ],),
                ),
              ),

            );
          }else{
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
        }
        );
  }


  holiday_list() async {
    final headers = {'Content-Type':'application/json'};
    var res = await http.get(
      Uri.parse('http://$ip/user/holiday'),
      headers: headers,
    );
    var notice   = json.decode(res.body);

    return notice;
  }

}
