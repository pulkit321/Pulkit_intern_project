import 'dart:math';

import 'package:flutter/material.dart';
import 'package:try1/main.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:try1/login1.dart';
import 'dart:io';
import 'package:cryptography/cryptography.dart';
import 'dart:ui';
import 'package:cmutil/cmutil.dart';
import  'dart:async' show Future;
import 'dart:convert' show json;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:basic_utils/basic_utils.dart';
//import 'package:flutter_config/flutter_config.dart';
import 'package:pem/pem.dart';
//import 'package:x25519/x25519.dart';

//import 'package:x25519/x25519.dart';
dynamic consentresponse;


// void error(FormatException err)
// {
//   print("error"+err.toString());
String finaldate='';
GetTomorrowDate(){
  var date=new DateTime.now().add(Duration(days:1)).toUtc().toString();
  var dateParse=DateTime.parse(date);
  var formattedDate="${dateParse.day}/${dateParse.month}/${dateParse.year}";

  finaldate=formattedDate.toString();

}
var now = new DateTime.now();
//var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
var DateFormatted=DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);

Future cryptic() async{

  final algorithm = X25519();
  final aliceKeyPair = await algorithm.newKeyPair();

  final bobKeyPair = await algorithm.newKeyPair();
  final bobPublicKey = await bobKeyPair.extractPublicKey();
  final sharedSecretKey = await algorithm.sharedSecretKey(
    keyPair: aliceKeyPair,
    remotePublicKey: bobPublicKey,

  );
   print("Public Key                ${bobPublicKey}");
  var Cons = jsonDecode(consentresponse.body);
  //consentresponse.body.consents[0].consentId
  print(consentresponse);
  print("Consenttt               ${Cons["consents"][0]["consentId"]}");

  
  // var user=consentresponse.body.fromJson(jsonDecode(Cons));
//   List<int> keyData = PemCodec(PemLabel.publicKey).decode("""
//                $bobPublicKey
// """);
//   String pemBlock = PemCodec(PemLabel.publicKey).encode(keyData);
//   print(pemBlock);
//
//
//   void genKeyAndX25519() {
//     var aliceKeyPair = newKeyPair();
//     var bobKeyPair = generateKeyPair();
//
//     var aliceSharedKey = X25519(aliceKeyPair.privateKey, bobKeyPair.publicKey);
//     var bobSharedKey = X25519(bobKeyPair.privateKey, aliceKeyPair.publicKey);
//
//     assert(ListEquality().equals(aliceSharedKey, bobSharedKey));
//   }

  // void useX25519() {
  //   const expectedHex =
  //       '89161fde887b2b53de549af483940106ecc114d6982daa98256de23bdf77661a';
  //   var x = List<int>.filled(32, 0);
  //   x[0] = 1;
  //
  //   for (var i = 0; i < 200; i++) {
  //     x = X25519(x, basePoint);
  //   }
  //   assert(HEX.encode(x) == expectedHex);
  // }

  dynamic response2 = await Cmutil.jsonRequest(
    method: "post",
    url_path:"fi-flow/request",
    header: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Device-type": "ANDROID",
      "req-sec-param": "1683263668687",
      "te-api-sec":"U2FsdGVkX1+g+tXRTK+QUZMS6g3Th7PU9IA4J31ZHwNe3sXOzNCCk0/XQpn1ou1tKPKx81/Epjk+O9yq2Zn4s0cxn/pKWNaWfyxrN+NO8cOGyDB+SF4et1RWcypSBfxiNpqXeS/dEfWkaU/KclxjhL0gZGIhXhlbIcfvsYSHv1H9CNo+P6jIVEg3QMq+Hb6lmf+C6tNQUvKXhztmO6oPiA==",
    },
    body: {
      "ver": "1.1.2",
      "timestamp":"2023-05-23T10:36:54.607Z",
      "txnid": "${Cons["consents"][0]["consentId"]}",
      "FIDataRange":{},
      "Consent":{"id:${Cons["consents"][0]["consentId"]},"

      //consents array->object->consentid(in_body)
      //response.body.consents[0].consentId
      "KeyMaterials":{"cryptoAlg:ECDH , "
          "curve:Curve25519,"
          "params:Curve25519,"
          "DHPublicKey":{
        "expiry:2023-05-24T10:36:54.610Z,"
            "Parameters:Curve25519,"
        //change into existing func
            "KeyValue:MIIBMTCB6gYHKoZIzj0CATCB3gIBATArBgcqhkjOPQEBAiB/////////////////////////////////////////7TBEBCAqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqYSRShRAQge0Je0Je0Je0Je0Je0Je0Je0Je0Je0Je0JgtenHcQyGQEQQQqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq0kWiCuGaG4oIa04B7dLHdI0UySPU1+bXxhsinpxaJ+ztPZAiAQAAAAAAAAAAAAAAAAAAAAFN753qL3nNZYEmMaXPXT7QIBCANCAARPay7b4rkgvgTMp0cjRriQ7O/ouY9I2OvkH3BTTVx5UxxMnKNxPuYmeTBHvD7H/8b/lvTY4l8Jkm7tnVfbGhzs"}},
      "Nonce":"QsulyqdhnydtMYXFyWlFHevWmWRE+nMaVWkAGArkCPk="
    }},
  error: error,
  );
  print(response2.header);
  print("BODY   ${response2.body}");

  if( response2.statusCode ==200  ){

  }
  else{print("error");}

}
class MainnPage extends StatefulWidget {
  String cookie;
  MainnPage(this.cookie);



  @override
  State<MainnPage> createState() => _MainnPageState();
}

class _MainnPageState extends State<MainnPage> {

  @override


  dynamic response;
  void error(FormatException err)
  {
    print("error"+err.toString());
  }

  Future fetchConsent() async{
    Cookie head=Cookie.fromSetCookieValue(widget.cookie);
    print(head.value);
    print(head.name);

    consentresponse = await Cmutil.jsonRequest(
      method: "get",
      url_path: "consents/active",
      header: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Cookie":"${head.name}=${head.value}"
      },
      error: error,
    );
    print("Headers    ${consentresponse.headers}");
    //   String he= "${response.headers["consentId"]}";
    print(jsonDecode(consentresponse.body));
    print(consentresponse.statusCode);
    //
    //   if( response.statusCode ==200  ){
    //
    //   }
    //   else{print("error");}
    //
  }
  final List<Widget> _screens = [
    // Content for Home tab
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const Text(
        'Home',
        style: TextStyle(fontSize: 40),

      ),

    ),
    // Content for Feed tab
    Container(
        child:Image.asset("assets/images/img.png",alignment: Alignment.center)
    ),
    Container(
      color: Colors.purple.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Feed',
        style: TextStyle(fontSize: 40),
      ),
    ),
    // Content for Favorites tab
    Container(
      color: Colors.red.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Favorites',
        style: TextStyle(fontSize: 40),
      ),
    ),
    // Content for Settings tab
    Container(
      color: Colors.pink.shade300,
      alignment: Alignment.center,
      child: const Text(
        'Settings',
        style: TextStyle(fontSize: 40),
      ),
    )
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Image.asset("assets/images/img.png", scale: 0.8),
                  //_menuItem(title: '   ', isActive: false),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Consents', style: TextStyle(fontSize: 32),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        _menuItem(
                            title: 'Help and policies        ', isActive: true),
                        _menuItem(
                            title: 'Pulkit Kohli', isActive: true),
                      ],
                    ),
                  ),
                  //_menuItem(title: 'User', isActive: true),


                ]),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 50),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Image.asset("assets/images/img.png", scale: 0.8),
                          //_menuItem(title: '   ', isActive: false),
                          //   _menuItem(title: 'Active', isActive: true,),

                          ElevatedButton(onPressed: fetchConsent, child:Text("Active")),
                          SizedBox(width: 20,),
                          //_menuItem(title: '   ', isActive: false),
                          _menuItem(title: 'Pending', isActive: true),
                          SizedBox(width: 20,),
                          //_menuItem(title: '   ', isActive: false),
                          _menuItem(title: 'Archive', isActive: true),
                        ]),
                    _registerButton("Create Consent")
                  ]),
            ),
            Divider(),
            Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      debugPrint('${response.headers["user"]}');
                    },
                    child: SizedBox(
                        width: 500,
                        height: 480,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text("User Information",style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            Divider(),
                            //ElevatedButton(onPressed: , child: Text('Request Information')),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("User:Pulkit",style: TextStyle(
                                fontSize: 22 ,
                                fontWeight: FontWeight.bold,
                              ),),

                            ),
                            Padding(padding: EdgeInsets.all(70.0),),
                            ElevatedButton(onPressed: () => cryptic() , child: Text("Data Request",style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),))
                          ],
                        )
                    ))
            ),
          ],
        )
    );
  }


  Widget Menu() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/img.png", scale: 0.8),
                  _menuItem(title: '   ', isActive: false),
                  _menuItem(title: 'Active', isActive: true),
                  _menuItem(title: '   ', isActive: false),
                  _menuItem(title: 'Pending', isActive: true),
                  _menuItem(title: '   ', isActive: false),
                  _menuItem(title: 'Archive', isActive: true),
                  Row(
                      children: <Widget>[
                        IconButton(onPressed: () {
                          debugPrint('Pending');
                        }, icon: Stack(
                          children: <Widget>[
                            Icon(Icons.add, color: Colors.black38),
                          ],
                        ))
                      ]),

                  _menuItem(
                      title: '                                                                                                                                                                                                                                                    ',
                      isActive: false),
                  _menuItem(title: 'Create Content', isActive: true),
                  _menuItem(title: '   ', isActive: false),
                  _menuItem(title: 'Blog', isActive: true),
                  _menuItem(title: '   ', isActive: false),


                ],

              ),

            ]
        ));
  }


  Widget _menuItem({String title = 'Title Menu', isActive = false}) {
    return MouseRegion(

      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          Text(
            '$title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.deepPurple : Colors.grey,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          isActive
              ? Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(30),
            ),
          )
              : SizedBox()
        ],
      ),
    );
  }

  Widget hello() {
    return hello();

    // String finaldate = '';
    // getTomorrowDate() {
    //   var date = new DateTime.now().add(Duration(days: 1)).toString();
    //   var dateParse = DateTime.parse(date);
    //   var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse
    //       .year}";
    //   setState(() {
    //     finaldate = formattedDate.toString();
    //   });
    // }
    // void error(FormatException err) {
    //   print("error" + err.toString());
    // }
    //
    // Future fetchConsent() async {
    //   Cookie head = Cookie.fromSetCookieValue(widget.cookie);
    //   print(head.value);
    //   print(head.name);
    //
    //   consentresponse = await Cmutil.jsonRequest(
    //     method: "get",
    //     url_path: "consents/active",
    //     header: {
    //       "Accept": "application/json",
    //       "Content-Type": "application/json",
    //       "Cookie": "${head.name}=${head.value}"
    //     },
    //     error: error,
    //   );
    //   print("Headers    ${response.headers}");
    //   print(jsonDecode(response.body));
    //   print(response.statusCode);
    //   print("${response.body["consents"]}");
    //
    //   if( response.statusCode ==200  ){
    //
    //   }
    //   else{print("error");}
    //
    // }
    Future cryptic() async {
      final algorithm = X25519();
      final aliceKeyPair = await algorithm.newKeyPair();

      final bobKeyPair = await algorithm.newKeyPair();
      final bobPublicKey = await bobKeyPair.extractPublicKey();
      final sharedSecretKey = await algorithm.sharedSecretKey(
        keyPair: aliceKeyPair,
        remotePublicKey: bobPublicKey,
      );
      var Cons = response.body["consents"];
      print("Consenttt               ${Cons}");
      var user = response.body.fromJson(jsonDecode(Cons));

      dynamic response2 = await Cmutil.jsonRequest(
        method: "post",
        url_path: "fi-flow/request",
        header: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Device-type": "ANDROID",
          "req-sec-param": "1683263668687",
          "te-api-sec": "U2FsdGVkX1+g+tXRTK+QUZMS6g3Th7PU9IA4J31ZHwNe3sXOzNCCk0/XQpn1ou1tKPKx81/Epjk+O9yq2Zn4s0cxn/pKWNaWfyxrN+NO8cOGyDB+SF4et1RWcypSBfxiNpqXeS/dEfWkaU/KclxjhL0gZGIhXhlbIcfvsYSHv1H9CNo+P6jIVEg3QMq+Hb6lmf+C6tNQUvKXhztmO6oPiA==",
        },
        body: {
          "ver": "1.1.2",
          "timestamp": new DateTime.now().toUtc().toIso8601String(),
          "txnid": Null,
          "Consent": "${user.consentId}",
          //consents array->object->consentid(in_body)
          //response.body.consents[0].consentId
          "KeyMaterials": {"cryptoAlg:ECDH , "
              "curve:${algorithm.keyPairType},"
              "params:Curve25519"},
          "DHPublicKey": {
            "expiry:${GetTomorrowDate()},"
                "Parameters:Curve25519,"
            //change into existing func
                "KeyValue:${bobPublicKey}"}
        },
        error: error,
      );

      print("BODY   ${response.body}");

      if (response.statusCode == 200) {

      }
      else {
        print("error");
      }
    }
    Column(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _menuItem(title: '', isActive: true),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
        ),
        Row(
          children: [
            _menuItem(title: 'Create account', isActive: true),
            _registerButton("register")
          ],
        ),
        Divider()],

    );
  }

  Widget _registerButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 8,
            blurRadius: 12,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}